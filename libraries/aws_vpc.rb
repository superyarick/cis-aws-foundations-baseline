require '_aws'

class AwsVpc < Inspec.resource(1)
  name 'aws_vpc'
  desc 'Verifies settings for AWS VPC'
  example "
    describe aws_vpc do
      it { should be_default }
      its('cidr_block') { should cmp '10.0.0.0/16' }
    end
  "

  include AwsResourceMixin

  def to_s
    "VPC #{vpc_id}"
  end

  [:cidr_block, :dhcp_options_id, :state, :vpc_id, :instance_tenancy, :is_default,].each do |property|
    define_method(property) do
      @vpc[property]
    end
  end

  def flow_logs
    return unless @exists
    backend = AwsVpc::BackendFactory.create
    filter = { name: "resource-id", values: [@vpc_id],}
    resp = backend.describe_flow_logs({filter: [filter]})
  end

  def flow_logs_enabled?
    return unless @exists
    !flow_logs.empty?
  end


  alias default? is_default

  private

  def validate_params(raw_params)
    validated_params = check_resource_param_names(
      raw_params: raw_params,
      allowed_params: [:vpc_id],
      allowed_scalar_name: :vpc_id,
      allowed_scalar_type: String,
    )

    if validated_params.key?(:vpc_id) && validated_params[:vpc_id] !~ /^vpc\-[0-9a-f]{8}/
      raise ArgumentError, 'aws_vpc VPC ID must be in the format "vpc-" followed by 8 hexadecimal characters.'
    end

    validated_params
  end

  def fetch_from_aws
    backend = AwsVpc::BackendFactory.create

    if @vpc_id.nil?
      filter = { name: 'isDefault', values: ['true'] }
    else
      filter = { name: 'vpc-id', values: [@vpc_id] }
    end

    resp = backend.describe_vpcs({ filters: [filter] })

    @vpc = resp.vpcs[0].to_h
    @vpc_id = @vpc[:vpc_id]
    @exists = !@vpc.empty?
  end

  class Backend
    class AwsClientApi
      BackendFactory.set_default_backend(self)

      def describe_vpcs(query)
        AWSConnection.new.ec2_client.describe_vpcs(query)
      end

      def describe_flow_logs(query)
        AWSConnection.new.ec2_client.describe_flow_logs(query)
      end
    end
  end
end
control "cis-aws-foundations-1.19" do
  title "Maintain current contact details"
  desc  "Ensure contact email and telephone details for AWS accounts are
current and map to more than one individual in your organisation.

'An AWS account supports a number of contact details, and AWS will use these to
contact the account owner if activity judged to be in breach of Acceptable Use
Policy or indicative of likely security compromise is observed by the AWS Abuse
team. Contact details should not be for a single individual, as circumstances
may arise where that individual is unavailable. Email contact details should
point to a mail alias which forwards email to multiple individuals within the
organisation; where feasible, phone contact details should point to a PABX hunt
group or other call-forwarding system."
  impact 'low'
  desc 'rationale', "If an AWS account is observed to be behaving in a
prohibited or suspicious manner, AWS will attempt to contact the account owner
by email and phone using the contact details listed. If this is unsuccessful
and the account behaviour needs urgent mitigation, proactive measures may be
taken, including throttling of traffic between the account exhibiting
suspicious behaviour and the AWS API endpoints and the Internet. This will
result in impaired service to and from the account in question, so it is in
both the customers' and AWS' best interests that prompt contact can be
established. This is best achieved by setting AWS account contact details to
point to resources which have multiple individuals as recipients, such as email
aliases and PABX hunt groups."
  tag "cis_impact": ""
  tag "cis_rid": "1.19"
  tag "cis_level": 1
  tag "csc_control": ""
  tag "nist": ["IA-4", "Rev_4"]
  tag "cce_id": ""
  desc 'check', "This activity can only be performed via the AWS Console, with a
user who has permission to read and write Billing information
(aws-portal:*Billing ).

* Sign in to the AWS Management Console and open the Billing and Cost
Management console at https://console.aws.amazon.com/billing/home#/.
* On the navigation bar, choose your account name, and then choose My Account.

* On the Account Settings page, review and verify the current details.
* Under Contact Information, review and verify the current details."
  desc 'fix',"This activity can only be performed via the AWS Console, with a
user who has permission to read and write Billing information
(aws-portal:*Billing ).


* Sign in to the AWS Management Console and open the Billing and Cost
Management console at https://console.aws.amazon.com/billing/home#/.
* On the navigation bar, choose your account name, and then choose My Account.

* On the Account Settings page, next to Account Settings, choose Edit.
* Next to the field that you need to update, choose Edit.
* After you have entered your changes, choose Save changes.
* After you have made your changes, choose Done.
* To edit your contact information, under Contact Information, choose Edit.
* For the fields that you want to change, type your updated information, and
then choose Update."

  describe "Control has to be tested manually" do
    skip "This control must be manually reviewed"
  end
end

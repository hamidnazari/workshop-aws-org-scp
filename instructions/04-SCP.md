## Service Control Policies

There are times that you may want certain services entirely disabled in your
account. For example, you organisation has its own Directory Service and you
want your users to continue using it.

Or, you may want your organisation to use only specific regions. While these
can be imposed using Permissions Boundaries, there is a central and less
repetitive way of doing this.

> **NOTE:** IAM Managed Policies have a 6KB character limit. Sooner or later
you will reach this limit as more statements are added to your policy.





Further Reading:

[SCP][1] policies syntax is similiar to that of IAM, with few exceptions :


![SCP Syntax](../images/SCP_Syntax.png)

[1]: https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_scp-syntax.html
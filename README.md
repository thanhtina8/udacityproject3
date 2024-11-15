## Introduction
Ensuring Quality Releases - Project Overview

In this project, you'll develop and demonstrate your skills in using a variety of industry leading tools, especially Microsoft Azure, to create disposable test environments and run a variety of automated tests with the click of a button. Additionally, you'll monitor and provide insight into your application's behavior, and determine root causes by querying the application’s custom log files.

For this project we use the following tools:

- Azure DevOps: For creating a CI/CD pipeline to run Terraform scripts and execute tests with Selenium, Postman and Jmeter
- Terraform: For creating Azure infrastructure as code (IaS)
- Postman: For creating a regression test suite and publish the results to Azure Pipelines.
- Selenium: For creating a UI test suite for a website.
- JMeter: For creating a Stress Test Suite and an Endurance Test Suite.
- Azure Monitor: For configuring alerts to trigger given a condition from an App Service.

![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Project_Overview.png)
  

## Getting Started
For this project we will follow the next steps:
1. Install our dependencies
2. Configure storage account and state backend for Terraform
3. Configure Pipeline Environment
4. Configure an Azure Log Analytics Workspace

## Install our dependencies
| Dependency | Link |
| ------ | ------ |
| Terraform | https://www.terraform.io/downloads.html |
| JMeter |  https://jmeter.apache.org/download_jmeter.cgi|
| Postman | https://www.postman.com/downloads/ |
| Python | https://www.python.org/downloads/ |
| Selenium | https://sites.google.com/a/chromium.org/chromedriver/getting-started |
| Azure DevOps | https://azure.microsoft.com/en-us/services/devops/ |

## Terraform
1.  Clone source code from Github repo
2.  Open a Terminal and connect to your Azure account to get the Subscription ID
3. Create a storage account to Store Terraform state.
   ```
    terraform/environments/test/configure-tfstate-storage-account.sh
   ```
4. Copy the storage_account_name, container_name, and access_key, and update the corresponding values in terraform/environments/test/main.tf accordingly.
   ```
   terraform {
        backend "azurerm" {
        storage_account_name = "tfstate3184714603"
        container_name       = "tfstate"
        key                  = "test.terraform.tfstate"
        access_key           = "rgbuPvxxO0+vuW0YnYGKe7cFBIhLbAKwqkBC05KIpKKCqe71mkEQgd7WjMEGgY+p/xURslarX5ma+AStwAe9lw=="
        }
    }
   ```
5. Update values in terraform/environments/test/terraform.tfvars
      ```
      # Azure subscription vars
      subscription_id = "xxxxxxxxxxxx"
      client_id = "xxxxxxxxxxxx"
      client_secret = "xxxxxxxxxxxx"
      tenant_id = "xxxxxxxxxxxx"
      ```
6. Generate an SSH key and perform a keyscan of your GitHub to obtain the known hosts.
    ```
    ssh-keygen -t rsa
    cat ~/.ssh/id_rsa.pub
    ```
## Azure DevOps Pipeline
1. Go to https://dev.azure.com/ using Udacity provide account to create new AzureDevops project or use your email to create.
2. Install below extensions :

|Extensions|Link|
|--|--|
|JMeter|https://marketplace.visualstudio.com/items?itemName=AlexandreGattiker.jmeter-tasks&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList|
|PublishHTMLReports|https://marketplace.visualstudio.com/items?itemName=LakshayKaushik.PublishHTMLReports&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList|
|Terraform|https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList|

3. Go to Project Settings > Pipelines > Service Connection > Azure Resource Manager > Service principal(manual), Create the new Service Connection
   
   ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/ServiceConnection.png)
4. Go to portal to create a VM to use as an Agent or request a default agent from Microsoft
    ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/HostedAgent.png)
5. Create a New Pipeline > select GitHub > Existing Azure Pipelines YAML file > Choose  **azure-pipelines.yaml**  file

6. When running pipeline to stage "UITest" you might facing error : "No resource found ..." because you not yet setup VM for running this step in Environment.

7. Go to Azure Pipeline > Environments > test > Add resource > Virtual machines
   ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Azure_Test_Enviroment_Create.png)
8. Copy command, SSH to the VM then run copied command
 ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Azure_Test_Enviroment_VM.png)

9. After finished #8 go back to pipeline and re-run
10. Now wait for pipeline to execute on the following Stages: Provision > Deployment > PerfTest > UITest > FunctionalTest
    ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Azure_Pipeline_Overall.png)
14. After the pipeline run complete successfully then check the Test result and deployed Azure app service is up
    ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Azure_TestPlan_Report_1.png)
    ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Azure_TestPlan_Report_2.png)
    ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Azure_TestPlan_Report_3.png)
    ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Fake_RestAPI.png)
## Configure Logging and Monitoring
1. Create a Log Analytics workspace

### Set up email alerts in the App Service:
1. Log into Azure portal and go to the AppService that you have created.
2. On the left-hand side, under **Monitoring**, click **Alerts**, then **New Alert Rule**.



3. Verify the resource is correct, then, click **Add a Condition** and choose **Http 404**.



4. Set the Threshold value of `1`. Then click **Done**.
5. Create an action group and name
6. Add “Send Email” for the Action Name, and choose **Email/SMS/Push/Voice** for the action type, and enter your email. Click **OK**.
7. Name the alert rule `Http 404`, and leave the severity at `3`, then click **Create**.

 ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Monitoring_Alert404_Rule.png)
### App Service Diagnostic Log Analytics Configuration

1. Go to the App service, then **Diagnostic Settings** > **Add Diagnostic Setting**.
2. Tick **AppServiceHTTPLogs** and **Send to Log Analytics Workspace** created in the previous step, then **Save**.
3. Go back to the App Service, then **App Service Logs**.
4. Turn on **Detailed Error Messages** and **Failed Request Tracing**, then **Save**.
5. Restart the app service.

###  Set up log analytics workspace properly to get logs:

1. Go to **Log Analytics Workspace** > Go to Virtual Machines(deprecated) and Connect the created VM to the Workspace ( Connect). Just wait that shows `Connected`.

 ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Monitoring_LogAnalytic_ConnectedVM.png)

### Set up custom logging:

1. In the log analytics workspace, go to **Tables** > **Create** > **New Custom Logs (MMA) > **Choose selenium.log File**.
   - Select the file `selenium.log` > **Next** > **Next**.
   - Enter the following paths as type Linux: `/var/log/selenium/selenium.log`.
   - Name it (`project3_selenium_logs_CL`) and click **Done**.
 ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Monitoring_LogAnalytic_CustomLog.png.png)

2. Go to the App Service web page, navigate the links, and generate 404 not found errors (e.g., by visiting non-existent pages).

3. After some minutes ( 3 to 10 minutes) , check the email inbox

### Monitoring & Observability

 ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Monitoring_Alert_Email.png)
 ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/MMonitoring_LogAnalytic_404.png)
 ![Agent](https://github.com/thanhtina8/udacityproject3/blob/main/Screenshoots/Monitoring_LogAnalytic_Selenium.png)




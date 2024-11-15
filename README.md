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
4. Copy the storage_account_name, container_name, and access_key, and update the corresponding values in terraform/environments/test/main.tf accordingly.

## Azure DevOps Pipeline
1. Go to https://dev.azure.com/ using Udacity provide account to create new AzureDevops project or use your email to create.
2. Install below extensions :

|Extensions|Link|
|--|--|
|JMeter|https://marketplace.visualstudio.com/items?itemName=AlexandreGattiker.jmeter-tasks&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList|
|PublishHTMLReports|https://marketplace.visualstudio.com/items?itemName=LakshayKaushik.PublishHTMLReports&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList|
|Terraform|https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList|

3. Go to Project Settings > Pipelines > Service Connection > Azure Resource Manager > Service principal(manual), Create the new Service Connection




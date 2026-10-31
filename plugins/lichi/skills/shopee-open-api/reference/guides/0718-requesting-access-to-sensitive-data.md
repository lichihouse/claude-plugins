# Requesting Access to Sensitive Data

> Nhóm: Getting Started · nguồn: https://open.shopee.com/developer-guide/718

 

Shopee Open Platform safeguards sellers’ business data and users’ personal data considered sensitive (including customer name, phone number, email address, and address).

 

By default, sensitive data is masked. Developers must complete specific security requirements to request access to unmasked sensitive data.

### **Eligibility Requirements**

To request access to sensitive business data, developers must meet the following conditions:

1.  Submit Penetration Test Report
    - Required for Third-party Partner Platform (ISV) Developers serving, or planning to serve, sellers in Thailand, Malaysia, Singapore, or the Philippines, as well as ISVs from China Cross-Border (CNCB) and Hong Kong Cross-Border (HKCB)
    - A valid penetration test report must be submitted through the Open Platform Console
2.  PII Necessity Declaration
    - Required for all developers whose applications require access to buyer PII.
    - Enable the PII Necessity Declaration toggle for applications that require buyer PII access.
    - Declare all IP addresses of the servers hosting your application that require access to OpenAPI.
    - If your application does not require buyer PII access, keep the toggle OFF.

⚠️ Note: For Third-party Partner Platform (ISV) Developers, approved sensitive data access is valid for ***two (2) years*** from the penetration test report’s issue date.

### **How to Submit a Penetration Test Report**

Follow the steps below to upload your penetration test report:

- Step 1: Log in to your **Open Platform console** using your developer account

*Note: Member accounts do not have permission to upload reports.*

- Step 2: Navigate to Personal Center → Account Information (**Chinese Mainland ISVs:** [*Link*](https://open.shopee.cn/console/person/account), **Other Region ISVs:** [*Link*](https://open.shopee.com/console/person/account))
- Step 3: Under Security Reports & Certifications Information, click "Add"

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=3nkzhcjEysHs%2BxVIeQP%2BiarSKdEmhwKjczzYD%2FJArvxFyZzMjDJFfVJ8RFX6cNqLFAYlHxz94fUYl8ONlEFGHw%3D%3D&image_type=png)

- Step 4: Under Security Report & Certification Type, Choose “Penetration Test Report”
- Step 5: Upload your latest penetration test report
- Step 6: Click “Save”

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=ukOwqouxK6zyCz8GXhJf1UXdCDjwO%2F%2BPzT61qRe4vZHYPG6QovDt2Yd1bXTHPaxy3FKwqPXsb0870c350msmzQ%3D%3D&image_type=png)

Review Timeline

- The submission status (Approved / Rejected) will be updated in the **Account Information** section.
- Review results are typically available within **10 working days**.

 

📌 Please refer to the bottom of this page for **best practices and guidelines** on penetration test report submissions.

### **How to Configure PII Necessity Declaration**

Follow the steps below to declare whether your application requires access to buyer PII.

- Step 1: Log in to your Open Platform console and navigate to App List. (Chinese Mainland ISVs: [Link](https://open.shopee.cn/console/app), Other Region ISVs: [Link](https://open.shopee.com/console/app))
- Step 2: Click Go Live and complete the required information.
- Step 3: Under PII Necessity Declaration, locate “Does this App require buyer PII access?”
- Step 4: Select the appropriate setting based on your application's requirements:
  - **Toggle ON** if your application requires access to buyer PII.
  - **Toggle OFF** if your application does not require access to buyer PII.
- Step 5: If you toggled the setting ON in Step 4, declare all required IP address(es). Otherwise, skip this step.

⚠️ **Important:** Please verify your IP addresses carefully before submission. Once buyer PII access is declared, only the IP addresses included in your declared list will be able to access OpenAPI.

- Step 6: Click **Submit** to save your declaration.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=Oe5D%2BO3UdAtKPVWj6Txm3Ji0vEozRUvKIYxnZTgwGDxtLCJH3ZtwHgBCJl8UyDaBDh9FON70sfl6lBpgcwYKAA%3D%3D&image_type=png)

 

### **Good Practices for Penetration Test Report Submission**

**1. Recommended Testing Providers**

To improve report quality and review efficiency, ISVs are encouraged to engage reputable, accredited penetration testers, such as:

- CREST Accredited Penetration Tester
- Offensive Security Certified Professional (OSCP)
- GIAC Certified Penetration Tester (GPEN)
- Certified Ethical Hacker (CEH)
- Certified Information Systems Security Professional (CISSP)
- EC-Council Certified Security Analyst (ECSA)
- CompTIA PenTest+
- AWS Security Competency Partners
- Alibaba Cloud Security Partners
- Qianxin (奇安信)
- 360 数字安全
- Sangfor (深信服)
- Chaitin (长亭科技)

Reports from other penetration testers will still be **reviewed and considered for approval** on a case-by-case basis.

 

**2. Report Quality Requirements**

A complete Penetration Test Report should:

- Cover the application's externally exposed attack surface.
- Assess all relevant systems and applications within the testing scope.
- Document the testing methodology, testing process, scope, and detailed findings.
- Include a comprehensive list of identified vulnerabilities.
- Confirm that all vulnerabilities have been remediated.
- Be based on **black-box penetration testing**.

**Please note:** Vulnerability scan reports alone are **not** acceptable and will not satisfy this requirement.

 

**3. Recommended Report Issuance Date**

- ISVs are encouraged to submit a penetration test report issued within the last **one (1) year**.
- Sensitive data access will be granted for **two (2) years** from the report issue date.

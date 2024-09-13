# Form_App

## Overview

This Flutter application is designed to showcase a multi-step form with different input fields, including PAN details, basic personal details, and Bank details. The app includes form validation and dynamic navigation between the steps. The final step includes a submit button that handles form submission.

## Features

- **Multi-step Form**: Navigate Navigate through PAN Details, Basic Details, and Bank Details.
- **Form Validation**: Ensure correct input formats and required fields.
- **Dynamic Input Handling**: Includes dropdown lists, date pickers, and conditional input fields.
- **Progress Indicator**: Shows completion status at the top of the page.
- **Custom Styling**: Cylindrical text fields and overall UI customization.

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine.
- An IDE with Flutter support (e.g., Android Studio, VS Code).
- Basic understanding of Flutter and Dart programming.

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/praveen5102/form_app.

2. **Navigate to Project Directory**

   ```bash
   cd form_app

3.**Install Dependencies**

   ```bash
   flutter pub get
```
4.**Run the Application

```bash
   flutter run
```

### Usage

#### 1. PAN Details Page

- **Enter PAN Number**: 
  - The PAN number must follow the format `AAAA1234A` (5 letters, 4 digits, and 1 letter). 
  - Example: `ABCDE1234F`
  - Input will be validated for correct format. If the format is incorrect, an error message will be displayed.

- **Continue to Next Step**:
  - After entering the PAN number, click the "Continue" button to navigate to the Basic Details page.

#### 2. Basic Details Page

- **PAN Type**:
  - Select the PAN type from the dropdown list:
    - `P`: For individuals
    - `B`: For Body of Individuals (BOI)
    - `A`: For Association of Persons (AOP)

- **Enter Your Name**:
  - Provide your name as per the PAN card.

- **Enter Date of Birth**:
  - Use the calendar widget to select your date of birth as per the PAN card.

- **Enter Address**:
  - Input your residential address.

- **Enter Pincode**:
  - Provide the postal code of your address.

- **Enter City**:
  - Input the city of your address.

- **Enter State**:
  - Provide the state of your address.

- **Same as Current Address**:
  - Check this box if your current address is the same as the address provided above. This will auto-fill the address fields.

- **Continue to Next Step**:
  - After entering all details, click the "Continue" button to navigate to the Bank Details page.

#### 3. Bank Details Page

- **Select Bank**:
  - Choose your bank from the dropdown list (e.g., State Bank of India, HDFC Bank, etc.).

- **Enter Account Number**:
  - Provide your bank account number.

- **Enter IFSC Code**:
  - Input the IFSC code for your bank branch.

- **Submit**:
  - Click the "Submit" button to finalize and handle form submission. Ensure all fields are correctly filled before submitting.

**Note**: Ensure you have completed all required fields before proceeding to the next step or submitting the form.


## Application Output




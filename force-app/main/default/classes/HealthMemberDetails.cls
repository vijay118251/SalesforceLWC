/*
 * @author Helix sfdc Team ,TCS
 *
 * <Purpose> To parse a response that's returned
 * from a call to an external service </Purpose>
 *
 * @date 06/04/2022
 */

public class HealthMemberDetails{

    /* memberId */
    public String memberId {get ; set;}
    /* entityNumber */
    public String entityNumber {get ; set;}
    /* title */
    public String title {get ; set;}
    /* forename */
    public String forename {get ; set;}
    /* surname */
    public String surname {get ; set;}
    /* gender */
    public String medRecognisedGender {get ; set;}
    /* identifiedGender */
    public String identifiedGender {get ; set;}
    /* dateOfBirth */
    public String dateOfBirth {get ; set;}
    /* contactDetails */
    public ContactDetails contactDetails {get ; set;}
    /* products */
    public Products[] products {get ; set;}
    /* error */
    public ErrorDetail error { get; set; }

    /* class to check ContactDetails */
    public class ContactDetails {
        /* addresses */
        public Addresses[] addresses;
        /* emailAddresses */
        public EmailAddresses[] emailAddresses;
        /* phones */
        public Phones[] phones;
    }

    /* class to check Phones */
    public class Phones {
        /* type */
        public String type;
        /* type */
        public String telephoneNumber;
        /* type */
        public String isCurrent;
    }

    /* class to check Addresses */
    public class Addresses {
        /* line1 */
        public String line0;
        /* line1 */
        public String line1;
        /* line2 */
        public String line2;
        /* line3 */
        public String line3 {get ; set;}
        /* line4*/
        public String line4 {get ; set;}
        /* line5*/
        public String line5;
        /* postcode */
        public String postcode;
        /* startDate */
        public String startDate;
        /* endDate */
        public String endDate;
        /* isCurrent */
        public String isCurrent;
        /* audit */
        public Audit audit;
    }

    /* class to check Audit  */
    public class Audit {
        /* createdBy */
        public String createdBy;
        /* createdDate */
        public String createdDate;
        /* lastUpdatedBy */
        public String lastUpdatedBy;
        /* lastUpdatedDate */
        public String lastUpdatedDate;
    }

    /* class to check EmailAddresses  */
    public class EmailAddresses {
        /* emailAddress */
        public String emailAddress;
        /* startDate */
        public String startDate;
        /* isCurrent */
        public String isCurrent;
        /* audit */
        public Audit audit;
    }

    /* class to check Products  */
    public class Products {
        /* membershipNumber */
        public String membershipNumber;
        /* planNumber */
        public String planNumber;
        /* businessType */
        public String businessType;
        /* roleCode */
        public String roleCode;
        /* roleDescription */
        public String roleDescription;
        /* coverStartDate */
        public String coverStartDate;
        /* coverEndDate */
        public String coverEndDate;
        /* dateOfJoining */
        public String dateOfJoining;
        /* status */
        public String status;
        /* parentMembershipNumber */
        public String parentMembershipNumber;
        /* planStartDate */
        public String planStartDate;
        /* renewalDate */
        public String renewalDate;
        /* previousRenewalDate */
        public String previousRenewalDate;
        /* productDetails */
        public ProductDetails productDetails;
        /* underwritingType */
        public UnderwritingType underwritingType;
        /* familyStatus */
        public FamilyStatus familyStatus;
    }

    /* class to check ProductDetails  */
    public class ProductDetails {
        
        /* productCode */
        public String productCode;
        /* productName */
        public String productName;
    }

    /* class to check UnderwitingType  */
    public class UnderwritingType {
        /* underwritingCode */
        public String underwritingCode;
        /* underwritingDescription */
        public String underwritingDescription;
    }

    /* class to check FamilyStatus  */
    public class FamilyStatus {
        /* statusCode */
        public String statusCode;
        /* statusDescription */
        public String statusDescription;
    }

    /* class to get member details  */
    public static HealthMemberDetails parse(String json){
        String jsonStr;
        jsonStr = json.replace('contact-details','contactDetails').
                replace('email-addresses','emailAddresses').
                replace('product-details','productDetails').
                replace('underwriting-type','UnderwritingType').
                replace('family-status','FamilyStatus');
        //return details
        return (HealthMemberDetails) System.JSON.deserialize(jsonStr, HealthMemberDetails.class);
    }
}
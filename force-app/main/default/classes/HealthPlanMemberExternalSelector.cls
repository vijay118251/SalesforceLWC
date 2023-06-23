/**
 * @Date     :    08-Mar-2022
 * @Author   :    Vijay 
 * @Desc     :     HealthPlanMemberExternalSelector class 
 * helps to get details of Member Information
 *
 * */

public class HealthPlanMemberExternalSelector {

    /*Connection Service*/ 
    private static final ConnectionService CONNECTIONSERVICE = new ConnectionService('MSA_API','integration-experience',ProductHouse.VITALITY);

    /*The getData method takes in externalId and is passed to 
    the getResponse method which 
    helps to create list of rows */
    public static List<Map<String, Object>> getData(DataSource.QueryContext context) {
        final String externalId = UtilityExternalObject.getExtrenalId(context);
        final HealthMemberDetails details= getResponse(externalId); 
        return details.error!= null?APIErrorHandler.getErrorRows(details.error):createRow(details,externalId);
    }

    /* The getResponse method takes in external id and helps to create the endpoint
    which helps to generate response and return details */
    private static HealthMemberDetails getResponse(String externalId) {
        final String endpoint = buildUrl(externalId);
        final String response = CONNECTIONSERVICE.get(endpoint);
        final HealthMemberDetails details = HealthMemberDetails.parse(response);
        return details;
    }

    /*  method constructor buildUrl
    The buildUrl method takes the endpoint to build the Url which is 
    used by the buildRequest method*/
    private static String buildUrl(String externalId) {
        String entityNumber;
        String memberNumber;
        //check if externalId already holding memberNumber
        if(externalId.split('-').size()>1) {
            entityNumber = externalId.split('-')[1];
            memberNumber = externalId.split('-')[3];
        } else {
            //if memberNumber is null query
            //final PlanMembershipsSelector selector = new PlanMembershipsSelector();
           // selector.setOrderBy('Membership_Number__c DESC NULLS LAST');
           // final Plan_Membership__c planMembership = selector.getMemberIdByEntity(externalId);
           // entityNumber = planMembership.entityNumber__c;
           // memberNumber = planMembership.Membership_Number__c;
        }
        final String productStatus= 'all';
        return 'servicing/1/members/' + entityNumber +
               '?product=health&productStatus=' + productStatus +
               '&memberIdentifier=' + memberNumber;
    }

    /* The create row method takes in the parameter and maps 
    the response with the fields of 
    external object */
    private static List<Map<String, Object>> createRow(HealthMemberDetails details,String externalId){
        final List<Map<String, Object>> rows =
            new List<Map<String, Object>>();
        Integer count = 1;
        for ( HealthMemberDetails.Products product: details.products ) {
            final Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId', count+'-'+details.entityNumber+'-'+product.planNumber+'-'+details.memberId+'-'+product.membershipNumber);
            row.put('DisplayUrl', product.planNumber);
            row.put('Health Plan Member', externalId);
            row.put('Contact', externalId);
            row.put('Name', details.title+' '+ details.forename+' '+ details.surname);
            row.put('Gender', details.medRecognisedGender);
            row.put('Gender Identity', details.identifiedGender);
            row.put('Date Of Birth', UtilityDateFormatting.getDateString(details.dateOfBirth));
            final String line0 = UtilityExternalObject.getActiveDetails(details.contactdetails.addresses,'line0','','');
            final String finalLine0 = line0 == null ?'':line0;
            final String line1 = UtilityExternalObject.getActiveDetails(details.contactdetails.addresses,'line1','','');
            final String finalLine1 = line1 == null ?'':line1;
            final String line2 = UtilityExternalObject.getActiveDetails(details.contactdetails.addresses,'line2','','');
            final String finalLine2 = line2 == null ?'':line2;
            final String line3 = UtilityExternalObject.getActiveDetails(details.contactdetails.addresses,'line3','','');
            final String finalLine3 = line3 == null ?'':line3;
            final String line4 = UtilityExternalObject.getActiveDetails(details.contactdetails.addresses,'line4','','');
            final String finalLine4 = line4 == null ?'':line4;
            final String line5 = UtilityExternalObject.getActiveDetails(details.contactdetails.addresses,'line5','','');
            final String finalLine5 = line5 == null ?'':line5;
            final String postcode = UtilityExternalObject.getActiveDetails(details.contactdetails.addresses,'postcode','','');
            final String finalPostcode = postcode == null ?'':postcode;
            row.put('Member Address', finalLine0 + ' '+ finalLine1 +' '+ finalLine2+' '+ finalLine3+' '+ finalLine4+' '+ finalLine5+' '+ finalPostcode);
            if(details.contactdetails.emailAddresses != null){
            row.put('Email Address',UtilityExternalObject.getActiveDetails(details.contactdetails.emailAddresses,'emailAddress','',''));}
            row.put('Plan', product.planNumber);
            row.put('Plan Number', product.planNumber);
            row.put('Plan Type', product.productDetails.productName);
            row.put('Cover Start Date', UtilityDateFormatting.getDateString(product.coverStartDate));
            row.put('Cover End Date', UtilityDateFormatting.getDateString(product.coverEndDate));
            row.put('Plan Start Date', UtilityDateFormatting.getDateString(product.planStartDate));
            row.put('Entity Role', product.roleDescription);
            row.put('Member Status', product.status);
            row.put('Member Number', details.memberId);
            if(product.underwritingType!=null){
                row.put('Exclusion Type Code', product.underwritingType.underwritingCode);
                row.put('Underwriting Description', product.underwritingType.underwritingDescription);
            }
            if(product.familyStatus!=null){
                row.put('Family Status', product.familyStatus.statusDescription);
            }
            if(details.ContactDetails.phones!= null){
                row.put('Mobile Number', UtilityExternalObject.getActiveDetails(details.ContactDetails.phones,'telephoneNumber','type','mobile'));
                row.put('Daytime Number', UtilityExternalObject.getActiveDetails(details.ContactDetails.phones,'telephoneNumber','type','daytime'));
                row.put('Evening Number', UtilityExternalObject.getActiveDetails(details.ContactDetails.phones,'telephoneNumber','type','evening'));       
            }
            if(product!=null){
                row.put('Membership Number', product.membershipNumber);
                if(product.parentMembershipNumber!=null){
                    row.put('Parent Membership Number', product.parentMembershipNumber);
                } else{
                    row.put('Parent Membership Number', product.membershipNumber);
                }
                row.put('Product Code', product.productDetails.productCode);
                row.put('Role Code', product.roleCode);              
            }
            row.put('Address Line1', finalLine1);
            row.put('Address Line2', finalLine2);
            row.put('Address Line3', finalLine3);
            row.put('Address Line4', finalLine4);
            row.put('Address Line5', finalLine5);
            row.put('Post Code', finalPostcode);
            rows.add(row);
            count++;
        }
        return rows;
    }
    
     /*The searchData method takes in externalId */
    /* external id helps to create list of rows 
    public static List<Map<String, Object>> searchData(DataSource.SearchContext context) {
        final String externalId = context.searchPhrase;
        final ConditionDetails details = getResponse(externalId);
        return details.error != null?
        APIErrorHandler.getErrorRow(details.error):createRowSearch(details,externalId);
    } 
    
    private static List<Map<String, Object>> createRowSearch(ConditionDetails details, String externalId){
        final List<Map<String, Object>> rows =
            new List<Map<String, Object>>();
        final Map<String, Object> row = new Map<String, Object>();
        for(ConditionDetails.ConditionDetail detail: details.conDetails ) {
            if(detail.isLive == true) {
                row.put('ExternalId', externalId);
                if(detail.primaryIcd != null) {
                    row.put('pirmaryConditionCode',detail.primaryIcd.icdCode +' ' +detail.primaryIcd.icdDescription);
                }
                if(detail.audit != null) {
                    row.put('createdDate',UtilityDateFormatting.getDateTimeString(detail.audit.createdDate));
                }
                row.put('claimType', 'MEDICAL');
                rows.add(row);
            }
        }
        return rows;*/
}
/*
 * <Purpose>Test class for MockHttpResponseGenerator</Purpose>
 *
 */
@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    /*Set Class Name*/
    public static Boolean setError = false;
    /* method */
    public static String method = 'GET';

    /*
     * Implement this interface method
     */
    global HTTPResponse respond(HTTPRequest req) {
        //check asssert
        if(!Test.isRunningTest()){
            System.assertEquals(method, req.getMethod());
        }
        final String endpoint = req.getEndpoint();
        // Create a fake response
        final HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        if (setError && !endpoint.endsWith('/messages')) {
            res.setBody(
                '{ "error": {' +
                '    "errorCode": 500,' +
                '    "errorDateTime": "2020-05-01T11:40:09",' +
                '    "errorMessage": "SOURCE_SYSTEM_ERROR : The resource requested could not be found",' +
                '    "errorDescription": " "' +
                '  }' +
                '}'
            );
            res.setStatusCode(500);
        } else if (endpoint.endsWith('members/')) {
            //set body
            res.setBody('{"example":"test"}');
            //set status code
            res.setStatusCode(200);
        } else if (endpoint.endsWith('12345678')) {
            //set body
            res.setBody(
                '{"entityNumber":"1234567890","title":"Mr","forename":"Munsuk","surname":"Bhat","gender":"Male","dateOfBirth":"1990-09-09","contact-details":{"addresses":[{"line1":"MARSHALL POINT","line2":"4 RICHMOND GARDENS","line3":"MAIN ROAD","line4":"BOURNEMOUTH","postcode":"BH1 1JD","startDate":"2019-01-02","isCurrent":true,"audit":{"createdBy":"LOUISE99","createdDate":"2019-01-01T16:41:41.090Z","lastUpdatedBy":"JOANN88","lastUpdatedDate":"2019-01-01T16:41:41.090Z"}}],"email-addresses":[{"emailAddress":"enptest@hotmail.co.uk","startDate":"2018-02-10","isCurrent":true,"audit":{"createdBy":"LOUISE99","createdDate":"2019-01-01T16:41:41.090Z","lastUpdatedBy":"JOANN88","lastUpdatedDate":"2019-01-01T16:41:41.090Z"}}],"phones":[{"type":"mobile","telephoneNumber":"07685909876","startDate":"2019-01-02","isCurrent":true,"audit":{"createdBy":"LOUISE99","createdDate":"2019-01-01T16:41:41.090Z","lastUpdatedBy":"JOANN88","lastUpdatedDate":"2019-01-01T16:41:41.090Z"}},{"type":"daytime","telephoneNumber":"01234998765","startDate":"2019-01-02","isCurrent":true,"audit":{"createdBy":"LOUISE99","createdDate":"2019-01-01T16:41:41.090Z","lastUpdatedBy":"JOANN88","lastUpdatedDate":"2019-01-01T16:41:41.090Z"}},{"type":"evening","telephoneNumber":"01202876190","startDate":"2014-01-02","isCurrent":true,"audit":{"createdBy":"LOUISE99","createdDate":"2019-01-01T16:41:41.090Z","lastUpdatedBy":"JOANN88","lastUpdatedDate":"2019-01-01T16:41:41.090Z"}}]},"products":[{"membershipNumber":"100000908123","coverStartDate":"2018-10-15","dateOfJoining":"2017-10-15","businessType":"Health","roleCode":"EMP","roleDescription":"Employee","status":"Active","planNumber":"50000734","product-details":{"productCode":"EBH","productName":"Business Healthcare"},"planStartDate":"2017-10-15","previousRenewalDate":"2018-10-15","renewalDate":"2019-10-15","underwriting-type":{"underwritingCode":"FMU","underwritingDescription":"Full Medical Underwriting"},"family-status":{"statusCode":"F03","statusDescription":"Family"}}]}'
            );
            //set status code
            res.setStatusCode(200);
        } else if (endpoint.contains('phf-details')) {
            //set body
            res.setBody(
                '[{"currentBalanceAmount":0.00,"allocatedAmount":75.00,"fundStartDate":"2018-09-15","fundEndDate":"2019-09-14","health-review-details":[{"membershipNumber":"100000951365","isHealthReviewRequired":true,"reviewStatus":"Completed","reviewCompletionDate":"2018-10-01"}]}]'
            );
            //set status code
            res.setStatusCode(200);
        } else if (endpoint.contains('exclusion')) {
            //set body
            res.setBody(
                '[{\"datePeriod\":{\"startDate\":\"2018-09-15\"},\"exclusionTypeCode\":\"002\",\"exclusionTypeDescription\":\"MORI internal transfer\",\"isActive\":true,\"moriStartDate\":\"2018-09-15\",\"exclusionRawDetails\":\"A 2 year moratorium clause has been applied by VitalityHealth with effect from 07 December 2018.\",\"audit\":{\"createdBy\":\"JOANN88\",\"createdDate\":\"2018-09-15T16:41:41.090Z\",\"lastUpdatedBy\":\"JOANN88\",\"lastUpdatedDate\":\"2018-09-15T16:41:41.090Z\"}},{\"datePeriod\":{\"startDate\":\"2018-01-01\",\"endDate\":\"2018-09-14\"},\"exclusionTypeCode\":\"001\",\"exclusionTypeDescription\":\"MORI external transfer\",\"isActive\":false,\"moriStartDate\":\"2018-01-01\",\"exclusionRawCodes\":\"2787, 523\",\"exclusionRawDetails\":\"Benefit will not be payable under this plan for any further investigations or treatment due to; -Prolapsed Disc -Acne\",\"audit\":{\"createdBy\":\"LOUISE99\",\"createdDate\":\"2018-01-01T16:41:41.090Z\",\"lastUpdatedBy\":\"JOANN88\",\"lastUpdatedDate\":\"2018-09-15T16:41:41.090Z\"}}]'
            );
            //set status code
            res.setStatusCode(200);
        } else if (endpoint.endsWith('000')) {
            //set body
            res.setBody(
                '{"planNumber":"50001234","planStartDate":"2017-10-15","previousRenewalDate":"2018-10-15","renewalDate":"2019-10-15","planStatus":"In Force","isPaidToDate":true,"outstandingPremium":0.00,"overpaidPremium":0.00,"payment-details":{"paymentMethod":{"code":"P01","shortDescription":"Direct Debit","longDescription":"Direct Debit"},"collectionFrequency":{"code":"P11","shortDescription":"Monthly","longDescription":"Monthly"},"collectionDay":15,"reconciliationFrequency":{"code":"P11","shortDescription":"Monthly","longDescription":"Monthly"},"policyFactor":0.987678,"rdpFactor":1.000000},"annual-premium-details":{"grossAmount":1200.00,"netAmount":1100.00,"iptAmount":75.00,"vatAmount":25.00},"product-details":{"productCode":"EBH","productName":"Business Healthcare"},"agent-details":[{"agentCode":"R012345","agentTypeCode":"DIR","salesChannel":"Direct Marketing"}]}'
            );
            //set status code
            res.setStatusCode(200);
        } else if (endpoint.endsWith('premiums')) {
            //set body
            res.setBody(
                '[{"datePeriod":{"startDate":"2018-01-01","endDate":"2018-03-31"},"premiumAmount":{"grossAmount":1200.00,"netAmount":1100.00,"iptAmount":75.00,"vatAmount":25.00},"paidAmount":1200.00},{"datePeriod":{"startDate":"2018-04-01","endDate":"2018-06-30"},"premiumAmount":{"grossAmount":1200.00,"netAmount":1100.00,"iptAmount":75.00,"vatAmount":25.00},"paidAmount":1200.00},{"datePeriod":{"startDate":"2018-07-01","endDate":"2018-09-30"},"premiumAmount":{"grossAmount":1200.00,"netAmount":1100.00,"iptAmount":75.00,"vatAmount":25.00},"paidAmount":1200.00},{"datePeriod":{"startDate":"2018-10-01","endDate":"2018-12-31"},"premiumAmount":{"grossAmount":1200.00,"netAmount":1100.00,"iptAmount":75.00,"vatAmount":25.00},"paidAmount":1200.00}]'
            );
            //set status code
            res.setStatusCode(200);
        } else if (endpoint.contains('claims') && endpoint.contains('conditions') ) {            
            //set body
            res.setBody(
                '[{"accidentCause":"Road Traffic Accident","accidentCauseId":1,"audit":{"createdBy":"User","createdDate":"2022-04-01T07:02:28.735Z","description":"User","lastUpdatedBy":"User","lastUpdatedDate":"2022-04-01T07:02:28.735Z"},"bodyAreaId":1,"bodyPart":"Brain","bodyPartId":1,"claimFormReceived":true,"conditionId":9294045,"description":"intestinal bacterial infections","firstSymptomGpDate":"2022-04-01T07:02:28.735Z","firstSymptomPatientDate":"2022-04-01T07:02:28.735Z","firstSymptomSpecialistDate":"2022-04-01T07:02:28.735Z","flareUpGpDate":"2022-04-01T07:02:28.735Z","flareUpPatientDate":"2022-04-01T07:02:28.735Z","flareUpSpecialistDate":"2022-04-01T07:02:28.735Z","gpReferralReceived":true,"isAccident":true,"isAcute":true,"isCancerRelated":true,"isChronic":true,"isDrugAlcoholRelated":"false","isLive":true,"isPregnancyRelated":"false","isPreviouslyReceivedInvestigativeProc":true,"isPreviouslyReceivedMedicalAdvice":true,"isPreviouslyReceivedMedication":true,"isPreviouslyReceivedTreatment":true,"isSuspectedDiagnosis":true,"isThirdParty":true,"narrative":"Non-cancerous (benign) growth of the blood vessels (haemangioma)","notifiedDate":"2022-04-01T07:02:28.735Z ","origin":"VGP","originId":4,"previouslyReceivedInvestigationDate":"2022-04-01T07:02:28.735Z","previouslyReceivedMedicalAdviceDate":"2022-04-01T07:02:28.735Z","previouslyReceivedMedicationDate":"2022-04-01T07:02:28.735Z","previouslyReceivedTreatmentDate":"2022-04-01T07:02:28.735Z","primaryConditionMedicalAdviceDate":"2022-04-01T07:02:28.735Z","primaryIcd":{"icdCode":"A04","icdDescription":"Other intestinal bacterial infections","icdLaymanDescription":"Other intestinal bacterial infections","medicalConditionId":453},"reportedBy":"Specialist","reportedById":3,"secondaryConditionMedicalAdviceDate":"2022-04-01T07:02:28.735Z ","secondaryConditionSymptomDate":"2022-04-01T07:02:28.735Z ","secondaryIcd":{"icdCode":"A04","icdDescription":"Other intestinal bacterial infections","icdLaymanDescription":"Other intestinal bacterial infections","medicalConditionId":376},"selfDeclarationReceived":true,"sideOfBody":"Not Applicable"}]'
                );
            //set status code
            res.setStatusCode(200);
        }  else if (endpoint.contains('claims')) {
            //set body
            res.setBody(
                '{ "claim-summary": [ { "planNumber": "50000734", "totalNumberOfClaims": 2, "totalClaimedAmount": 12345, "totalPaidAmount": 12300 } ], "claims": [ { "claimNumber": "9285268", "claim-type": { "shortDescription": "MEDICAL", "description": "Medical" }, "status-type": { "shortDescription": "Accept", "description": "Condition Accepted" }, "recentCondition": { "conditionCode": "A00.1", "conditionDescription": "Cholera due to Vibrio cholerae 01, biovar eltor" }, "recentConditionDecision": "Accept", "recentTreatmentDecision": "Refer", "planNumber": "50000734", "audit": { "createdBy": "LOUISE48", "createdDate": "2016-02-28T16:41:41.000Z", "lastUpdatedBy": "JOANN23", "lastUpdatedDate": "2016-02-28T16:41:41.000Z" } }, { "claimNumber": "9285269", "claim-type": { "shortDescription": "MEDICAL", "description": "Medical" }, "status-type": { "shortDescription": "Accept", "description": "Condition Accepted" }, "recentCondition": { "conditionCode": "A119", "conditionDescription": "Fever" }, "recentConditionDecision": "Accept", "recentTreatmentDecision": "Refer", "planNumber": "50000734", "audit": { "createdBy": "LOUISE48", "createdDate": "2017-03-28T12:41:42.000Z", "lastUpdatedBy": "JOANN23", "lastUpdatedDate": "2017-03-28T12:42:41.000Z" } } ] }'
            );
            //set status code
            res.setStatusCode(200);
        } else if (endpoint.contains('treatments')) {
            //set body
            res.setBody(
                '{"treatmentId": "1","isManagedByPartner": "true","reportedBy": "text","referredBy": "text","firstConsultationDate": "text","startDate": "text","endDate": "text","lengthOfStay": "1","validUntilDate": "text","authorisationCode": "text","typeDescription": "text","treatmentDescription": "text","status-type": { "shortDescription": "Accept", "description": "Condition Accepted" },"firstVisitDate": "text","practitionerGroup": "text","codeDescription": "text","isOfflistHospitalApproved": true,"partners": { "type": "text", "description": "text" },"opcs": { "code": "text", "description": "text", "laymanDescription": "text" },"specialists": { "title": "text", "forename": "text", "surname": "text" },"hospital": {  "name": "text" },"treatment-baskets": { "name": "text", "treatment": "text",  "type": "text", "totalSessionsCount": 1, "systemSessionsCount": 1, "manualSessionsCount": 1},"audit": { "createdBy": "text" "createdDate": "text", "lastUpdatedBy": "text", "lastUpdatedDate": "text"}}'
            );
            //set status code
            res.setStatusCode(200);
        } else if (endpoint.contains('treatment-decisions')) {
            //set body
            res.setBody(
                '{"userDecision": "text","assessmentDate": "text","assessorId": "text","recommendedDecision": "text","overrideReason": "text","isReferredToManagedCare": true,"otherReason": "text","status-type":{ "shortDescription": "text", "description": "text"},"decisionReasons": { "reasonId": "text",  "reasonDescription": "text" },"authorisedCode": "text"}'
            );
            //set status code
            res.setStatusCode(200);
        } else if (endpoint.contains('condition-decisions')) {
            res.setBody(
                '{[{"userDecision":"More Info","assessmentDate":"2019-01-15","assessorId":"SATHISH3","recommendedDecision":"Declined","overrideReason":"User Decision","isReferredToManagedCare":true,"otherReason":"Customer shared additional details","status-type":{"shortDescription":"6 Waiting Doctor Report","description":"Requested Medical Report"},"decisionReasons":[{"reasonId":"25","reasonDescription":"More Information Needed From GP Before a Decision can be made"},{"reasonId":"26","reasonDescription":"More Information Needed From Dentist Before a Decision can be made"}]},{"userDecision":"More Info","assessmentDate":"2019-01-17","assessorId":"SATHISH3","recommendedDecision":"Declined","overrideReason":"User Decision","isReferredToManagedCare":true,"otherReason":"Customer shared additional details","status-type":{"shortDescription":"20 Waiting  for Proof","description":"Awaiting Practioners name"},"decisionReasons":[{"reasonId":"75","reasonDescription":"Proof Needed"}]}]}'
            );
        } else if (endpoint.contains('claimOwners')) {
            //set body
            res.setBody(
                '[  {    "teamName": "Vitality Care",    "subTeamName": "Oncology",    "caseManagerName": "Test",    "startDate": "2020-07-07",    "contactNumber": "01234567890",    "isActive": true,    "audit": {        "createdBy": "MURARI1",        "createdDate": "2020-07-07T17:43:17.000Z"    }},  {"teamName": "CFT","subTeamName": "Complex Claims","startDate": "2020-07-07","isActive": false,"audit": {"createdBy": "MURARI1","createdDate": "2020-07-07T17:50:17.000Z"}}]'
            );
            //set code
            res.setStatusCode(200);
        } else if (endpoint.contains('categories')) {
            res.setBody(
                '[{ \"categoryName\": \"Category 2\", \"categoryCode\": \"002\", \"coverTypeDescription\": \"PmiCover\",  \"packageType\": \"Single\", \"benefitStartDate\": \"2020-05-31\", \"benefitEndDate\": \"2021-05-30\", \"coverDetails\": { \"hospitalList\": \"Countrywide\", \"excessType\": \"Per claim\", \"excessAmount\": 100, \"isExcessStatusLinked\": true, \"statusLinkedExcessType\": \"Status Linked Excess (max £250)\", \"modules\": [ { \"moduleCode\": \"B01\", \"moduleDescription\": \"Included\", \"moduleDescriptionGUI\": \"Core Cover\", \"moduleCategoryCode\": \"PMI\", \"moduleCategoryDescription\": \"Private Medical Insurance\", \"benefits\": [ {  \"benefitId\": 1,  \"description\": \"ACCOMMODATION AND HOSPITAL CHARGES\",  \"shortDescription\": \"I/P Charges\",  \"isMedicalBenefit\": true,  \"isFlexBenefit\": false,  \"benefitExcessLimit\": 0.0, \"isAccumulated\": false,  \"child-benefits\": [ { \"benefitId\": 80, \"description\": \"ACCOMMODATION\", \"shortDescription\": \"I/P Accommodation\", \"isMedicalBenefit\": true, \"isFlexBenefit\": false, \"benefitExcessLimit\": 0.0, \"isAccumulated\": false } ] } ] } ] } }]'
            );
            res.setStatusCode(200);
        } else if (endpoint.contains('benefits')) {
            res.setBody(
                '{ \"categoryName\": \"Category 2\", \"categoryCode\": \"002\", \"coverTypeDescription\": \"PmiCover\",  \"packageType\": \"Single\", \"benefitStartDate\": \"2020-05-31\", \"benefitEndDate\": \"2021-05-30\", \"coverDetails\": { \"hospitalList\": \"Countrywide\", \"excessType\": \"Per claim\", \"excessAmount\": 100, \"isExcessStatusLinked\": true, \"statusLinkedExcessType\": \"Status Linked Excess (max £250)\", \"modules\": [ { \"moduleCode\": \"B01\", \"moduleDescription\": \"Included\", \"moduleDescriptionGUI\": \"Core Cover\", \"moduleCategoryCode\": \"PMI\", \"moduleCategoryDescription\": \"Private Medical Insurance\", \"benefits\": [ {  \"benefitId\": 1,  \"description\": \"ACCOMMODATION AND HOSPITAL CHARGES\",  \"shortDescription\": \"I/P Charges\",  \"isMedicalBenefit\": true,  \"isFlexBenefit\": false,  \"benefitExcessLimit\": 0.0, \"isAccumulated\": false,  \"child-benefits\": [ { \"benefitId\": 80, \"description\": \"ACCOMMODATION\", \"shortDescription\": \"I/P Accommodation\", \"isMedicalBenefit\": true, \"isFlexBenefit\": false, \"benefitExcessLimit\": 0.0, \"isAccumulated\": false } ] } ] } ] } }'
            );
            res.setStatusCode(200);
        } else if (endpoint.endsWith('/messages')) {
            if (setError) {
                res.setBody(
                    '{' +
                    '\"rid\": \"null\",' +
                    '\"eid\": \"MSA-3e05048a-32a6-4ea3-bf6d-79e37fdcdbea\",' +
                    '\"errorCode\": 400,' +
                    '\"errorMessage\": \"BAD_REQUEST\",' +
                    '\"errorDescription\": \"One or more mandatory information is missing in the request\",' +
                    '\"date\": \"Fri Mar 26 16:26:06 GMT 2021\"' +
                    '}'
                );
                res.setStatusCode(400);
            } else {
                res.setBody('{ \"message\": \"Comms request accepted for processing\"}');
                res.setStatusCode(202);
            }
        } else if (endpoint.endsWith('Error/Invalid')) {
            res.setBody('{"Error":"Invalid response"}');
            res.setStatusCode(500);
        } else if (endpoint.endsWith('Error/empty')) {
            res.setBody(null);
            res.setStatusCode(500);
        }
        return res;
    }
 }
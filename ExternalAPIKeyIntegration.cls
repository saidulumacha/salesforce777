public class ExternalAPIKeyIntegration {
     public static void getPartRecFromCQ() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:External_Named_Credential');
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HttpResponse res = http.send(req);
        List<Map<String, Object>> responseList = (List<Map<String, Object>>)JSON.deserializeUntyped(res.getBody());
        List<SQX_Part__c> partRecords = new List<SQX_Part__c>();
        for (Map<String, Object> responseMap : responseList) {
            SQX_Part__c partRecord = new SQX_Part__c();
            partRecord.Name = (String)responseMap.get('part_name');
            partRecord.Part_Number__c = (String)responseMap.get('_id');
            partRecord.Active__c = true;
            // Set Related Account field based on business logic
            Integer totalQuantityShipped = (Integer)responseMap.get('total_quantity_shipped');
            String accountName = (totalQuantityShipped < 99) ? 'High Volume' : 'Low Volume';
            List<Account> accounts = [SELECT Id FROM Account WHERE Name = :accountName LIMIT 1];
            if (!accounts.isEmpty()) {
                partRecord.Related_Account__c = accounts[0].Id;
            }
            partRecords.add(partRecord);
        }
        insert partRecords;
    }

}
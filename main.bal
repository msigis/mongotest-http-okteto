import ballerina/http;
import ballerina/log;
import ballerinax/mongodb;


type Student record {
    string Name;
    int Grade;
    map<any> Marks;
};
http:Client clientEndpoint = check new ("http://postman-echo.com");



service /hello on new http:Listener(9090) {

  

    // The `orderDetails` parameter in [Payload annotation](https://docs.central.ballerina.io/ballerina/http/latest/records/Payload)
    // represents the entity body of the inbound request..
    resource function post bindJson(@http:Payload json orderDetails)
            returns json|http:BadRequest {
       
        mongodb:ClientConfig mongoConfig = {
           // host: "localhost",
           host: "mongodb1",
            port: 27017,
          //  username: "admin",
           // password: "admin",
            options: {sslEnabled: false, serverSelectionTimeout: 5000}
        };
        mongodb:Client mongoClient = checkpanic new (mongoConfig, "Ballerina");
          map<json> doc1 = { "name": "ballerina", "type": "src" };
    map<json> doc2 = { "name": "connectors", "type": "artifacts" };
    map<json> doc3 = { "name": "docerina", "type": "src" };
    map<json> doc4 = { "name": "test", "type": "artifacts" };

    log:printInfo("------------------ Inserting Data -------------------");
    checkpanic mongoClient->insert(doc1,"projects");
    checkpanic mongoClient->insert(doc2,"projects");
    checkpanic mongoClient->insert(doc3,"projects");
    checkpanic mongoClient->insert(doc4,"projects");
  
    log:printInfo("------------------ Counting Data -------------------");
    int count = checkpanic mongoClient->countDocuments("projects",());
    log:printInfo("Count of the documents '" + count.toString() + "'.");


    log:printInfo("------------------ Querying Data -------------------");
    map<json>[] jsonRet = checkpanic mongoClient->find("projects",(),());
    log:printInfo("Returned documents '" + jsonRet.toString() + "'.");

    map<json> queryString = {"name": "connectors" };
    jsonRet = checkpanic mongoClient->find("projects", (), queryString);
    log:printInfo("Returned Filtered documents '" + jsonRet.toString() + "'.");


    log:printInfo("------------------ Updating Data -------------------");
    map<json> replaceFilter = { "type": "artifacts" };
    map<json> replaceDoc = { "name": "main", "type": "artifacts" };

    int responseDB = checkpanic mongoClient->update(replaceDoc,"projects", (), replaceFilter, true);
    if (responseDB > 0 ) {
        log:printInfo("Modified count: '" + responseDB.toString() + "'.") ;
    } else {
        log:printInfo("Error in replacing data");
    }

   log:printInfo("------------------ Deleting Data -------------------");
   map<json> deleteFilter = { "name": "ballerina" };
   int deleteRet = checkpanic mongoClient->delete("projects", (), deleteFilter, true);
   if (deleteRet > 0 ) {
       log:printInfo("Delete count: '" + deleteRet.toString() + "'.") ;
   } else {
       log:printInfo("Error in deleting data");
   }

     mongoClient->close();


        //Accesses the JSON field values.
        var details = orderDetails.Details;
        if (details is json) {
            return details;
        } else {
            http:BadRequest response = {body: "Order Details unavailable"};
            return response;
        }
    }


  
    //Binds the XML payload of the inbound request to the `store` variable.
    @http:ResourceConfig {
        consumes: ["application/xml"]
    }
    resource function post bindXML(@http:Payload xml store) returns xml {
        //Accesses the XML content.
        xml city = store.selectDescendants("{http://www.test.com}city");
        return city;
    }

    //Binds the JSON payload to a custom record. The payload's content should
    //match the record.
    @http:ResourceConfig {
        consumes: ["application/json"]
    }
    resource function post bindStruct(@http:Payload Student student)
            returns json {
        //Accesses the fields of the `Student` record.
        string name = <@untainted>student.Name;
        int grade = <@untainted>student.Grade;
        string english = <@untainted string>student.Marks["English"];
        return {Name: name, Grade: grade, English: english};
    }

  
    resource function post test()
            returns json {
        log:printInfo(" test httpClient");
        var responseClient = clientEndpoint->get("/get?test=123");

        handleResponse(responseClient);
              //Accesses the fields of the `Student` record.
    if (responseClient is http:Response) {
        string contentType = responseClient.getContentType();
        log:printInfo("Content-Type: " + contentType);

        int statusCode = responseClient.statusCode;
        log:printInfo("Status code: " + statusCode.toString());
        return {Name: responseClient.statusCode, Grade: "", English: ""};
    } else {
        log:printInfo("Error when calling the backend: " +   responseClient.message());
        return {Name: responseClient.message(), Grade: "", English: ""};
    }
     
    }
}

function handleResponse(http:Response|error response) {
    if (response is http:Response) {

        var msg = response.getJsonPayload();
        if (msg is json) {
            log:printInfo(msg.toJsonString());
        } else {
            log:printInfo("Invalid payload received:" + msg.message());
        }
    } else {
        log:printInfo("Error when calling the backend: " + response.message());
    }
}
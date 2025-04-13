# AT automation lambda to annotate or remove through xpath

This lambda permits a batch operation to annotate through a list xpath.

### Deploy locally with Docker
- Build docker image:

```
    docker build -t spotify-model-service:latest .
```

- Export AWS credentials and `APP_ENV` with the next command from command-line 
`export APP_ENV=./resources/app_env/stg.ini` otherwise, the container will not find the config file.
- Create a container:
```
    docker run -p 9000:8080 --name  xpath-automation:latest \        
        spotify-model-service:latest
```
- Test with curl
  

(Attached Postman Collections) 
    
    Add_annotations_locally
    Rm_annotations_locally

**xpath Annotations** 
```
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"version":"1.0", "body": \" {"\"team\":\"TEAM\", \"user\": \"USER@morningstar.com\", \"documentId\":\"DOC_ID\", \"fileName\": \"FILE.html\", \"xpathStringList\" : \"[ json xpath string ]\", "headers":{"Content-Type":"application/json"}, "httpMethod":"POST", "path":"/at-auto-xpath-ops", \"requestContext\": { \"extendedRequestId\" : \"example request id\" }}'
```

**xpath deletion**
```
curl -XDELETE "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"version":"1.0", "body": \" {"\"team\":\"TEAM\", \"user\": \"USER@morningstar.com\", \"documentId\":\"DOC_ID\", \"fileName\": \"FILE.html\", \"datapointIdList\" : \"[ list xpath ids to remove ]\", "headers":{"Content-Type":"application/json"}, "httpMethod":"DELETE", "path":"/at-auto-xpath-ops", \"requestContext\": { \"extendedRequestId\" : \"example request id\" }}'
```

### Testing from API Gateway 
- Consume the next path:

(Attached Postman Collections)

    add_annotations
    remove_annotations
    
With the previous methods **POST** to add annotations and **DELETE** to remove them
```
https://annotation-tool-ui-dev-automation.dc68032.easn.morningstar.com/at-auto-xpath-ops

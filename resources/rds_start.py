import boto3
def lambda_handler(event, context):
    rds_client = boto3.client('rds')
    tag_Key = event.get('tagKey')
    tag_value = event.get('tagValue')    
    response = rds_client.describe_db_instances()    
    for instance in response['DBInstances']:
        instance_arn = instance['DBInstanceArn']        
        tags_response = rds_client.list_tags_for_resource(ResourceName=instance_arn)        
        if instance['DBInstanceStatus'] == 'stopped':
            for tag in tags_response['TagList']:
                if tag['Key'] == tag_Key and tag['Value'] == tag_value:
                    rds_client.start_db_instance(DBInstanceIdentifier=instance['DBInstanceIdentifier'])
                    print(f"Se encendió la instancia RDS: {instance['DBInstanceIdentifier']}")   
    return {
        'statusCode': 200,
        'body': 'Proceso completado'
    }

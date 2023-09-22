import boto3

def lambda_handler(event, context):
    aurora_client = boto3.client('rds')

    tag_key = event.get('tagKey')
    tag_value = event.get('tagValue')
 
    response = aurora_client.describe_db_clusters()

    for cluster in response['DBClusters']:
        cluster_identifier = cluster['DBClusterIdentifier']
        cluster_arn = cluster['DBClusterArn']

        tags_response = aurora_client.list_tags_for_resource(ResourceName=cluster_arn)

        if cluster['Status'] == 'available':
            for tag in tags_response['TagList']:
                if tag['Key'] == tag_key and tag['Value'] == tag_value:
                    aurora_client.stop_db_cluster(DBClusterIdentifier=cluster_identifier)
                    print(f"Se apagó el clúster Aurora: {cluster_identifier}")

    return {
        'statusCode': 200,
        'body': 'Proceso completado'
    }

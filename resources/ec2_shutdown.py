import boto3
def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    tag_Key = event.get('tagKey')
    tag_value = event.get('tagValue')
    filters = [{'Name': tag_Key, 'Values': [tag_value]}, {
        'Name': 'instance-state-name', 'Values': ['running']}]
    instances = ec2.describe_instances(Filters=filters)
    instance_ids = [instance['InstanceId'] for reservation in instances['Reservations']
                    for instance in reservation['Instances']]
    if len(instance_ids) > 0:
        ec2.stop_instances(InstanceIds=instance_ids)
        return f"{len(instance_ids)} instances stopped."
    else:
        return "No instances found to stop."


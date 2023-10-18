import boto3

def stop_instances_with_tag(tag_key, tag_value):    
    ec2 = boto3.resource('ec2')
    instances = ec2.instances.filter(Filters=[{'Name': f'tag:{tag_key}', 'Values': [tag_value]}])
    instances_to_stop = [instance.id for instance in instances if instance.state['Name'] == 'running']

    if instances_to_stop:
        ec2_client = boto3.client('ec2')
        ec2_client.stop_instances(InstanceIds=instances_to_stop)

def suspend_processes_for_auto_scaling_groups_with_tag(tag_key, tag_value):
    asg_client = boto3.client('autoscaling')
    response = asg_client.describe_auto_scaling_groups()
    groups_to_suspend = []

    for group in response['AutoScalingGroups']:
        for tag in group['Tags']:
            if tag['Key'] == tag_key and tag['Value'] == tag_value:
                groups_to_suspend.append(group['AutoScalingGroupName'])

    for group_name in groups_to_suspend:
        asg_client.suspend_processes(AutoScalingGroupName=group_name)
        print(f"Suspendiendo procesos para el grupo de Auto Scaling: {group_name}")


def lambda_handler(event, context):
    tag_key = event.get('tag_key')
    tag_value = event.get('tag_value')

    suspend_processes_for_auto_scaling_groups_with_tag(tag_key, tag_value)
    stop_instances_with_tag(tag_key, tag_value)

    return {
        'statusCode': 200,
        'body': 'Process Complete.'
    }

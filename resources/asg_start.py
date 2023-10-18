import boto3

def resume_processes_for_auto_scaling_groups_with_tag(tag_key, tag_value):
    asg_client = boto3.client('autoscaling')
    response = asg_client.describe_auto_scaling_groups()
    groups_to_resume = []

    for group in response['AutoScalingGroups']:
        for tag in group['Tags']:
            if tag['Key'] == tag_key and tag['Value'] == tag_value:
                groups_to_resume.append(group['AutoScalingGroupName'])

    for group_name in groups_to_resume:
        asg_client.resume_processes(AutoScalingGroupName=group_name)
        print(f"Habilitando procesos para el grupo de Auto Scaling: {group_name}")


def start_instances_with_tag(tag_key, tag_value):    
    ec2 = boto3.resource('ec2')
    instances = ec2.instances.filter(Filters=[{'Name': f'tag:{tag_key}', 'Values': [tag_value]}])
    instances_to_start = [instance.id for instance in instances if instance.state['Name'] == 'stopped']

    if instances_to_start:
        ec2_client = boto3.client('ec2')
        ec2_client.start_instances(InstanceIds=instances_to_start)
        
def lambda_handler(event, context):
    tag_key = event.get('tag_key')
    tag_value = event.get('tag_value')

    start_instances_with_tag(tag_key, tag_value)
    resume_processes_for_auto_scaling_groups_with_tag(tag_key, tag_value)

    return {
        'statusCode': 200,
        'body': 'Process Complete.'
    }

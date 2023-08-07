import boto3

def get_asg_by_tag(tag_key, tag_value):    
    asg_client = boto3.client('autoscaling')
    response = asg_client.describe_auto_scaling_groups()
    for asg in response['AutoScalingGroups']:
        tags = {tag['Key']: tag['Value'] for tag in asg.get('Tags', [])}
        if tags.get(tag_key) == tag_value:
            return asg['AutoScalingGroupName']

def disable_asg(asg_name):    
    asg_client = boto3.client('autoscaling')
    asg_client.suspend_processes(AutoScalingGroupName=asg_name)    

def stop_instances_with_tag(tag_key, tag_value):    
    ec2 = boto3.resource('ec2')
    instances = ec2.instances.filter(Filters=[{'Name': f'tag:{tag_key}', 'Values': [tag_value]}])
    instances_to_stop = [instance.id for instance in instances if instance.state['Name'] == 'running']

    if instances_to_stop:
        ec2_client = boto3.client('ec2')
        ec2_client.stop_instances(InstanceIds=instances_to_stop)
        
def lambda_handler(event, context):
    tag_key = event.get('tag_key')
    tag_value = event.get('tag_value')

    asg_name = get_asg_by_tag(tag_key, tag_value)
    if not asg_name:
        print(f"No ASG found with tag {tag_key}={tag_value}.")
    else:
        disable_asg(asg_name)
        stop_instances_with_tag(tag_key, tag_value)

    return {
        'statusCode': 200,
        'body': 'Process Complete.'
    }
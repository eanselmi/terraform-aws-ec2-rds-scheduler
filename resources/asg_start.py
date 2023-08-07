import boto3

def get_asg_by_tag(tag_key, tag_value):
    asg_client = boto3.client('autoscaling')
    response = asg_client.describe_auto_scaling_groups()
    for asg in response['AutoScalingGroups']:
        tags = {tag['Key']: tag['Value'] for tag in asg.get('Tags', [])}
        if tags.get(tag_key) == tag_value:
            return asg['AutoScalingGroupName']

def enable_asg(asg_name):    
    asg_client = boto3.client('autoscaling')
    asg_client.resume_processes(AutoScalingGroupName=asg_name)
    print(f"ASG '{asg_name}' enabled.")

def lambda_handler(event, context):
    tag_key = event.get('tag_key')
    tag_value = event.get('tag_value')

    asg_name = get_asg_by_tag(tag_key, tag_value)
    if not asg_name:
        print(f"No ASG found with tag tag {tag_key}={tag_value}.")
    else:
        enable_asg(asg_name)

    return {
        'statusCode': 200,
        'body': 'Process complete.'
    }

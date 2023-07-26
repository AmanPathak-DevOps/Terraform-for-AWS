import boto3

def lambda_handler(event, context):
    # Creating EC2 Client
    ec2 = boto3.client('ec2')

    # Fetching all the ec2 snapshots
    response = ec2.describe_snapshots(OwnerIds=['self'])
    
    # Listing all the EBS Snapshots
    # for snapshot in response['Snapshots']:
    #     print(f'Snapshot ID: {snapshot["SnapshotId"]}, VolumeID: {snapshot["VolumeId"]}\n')
    
    
    # Fetching all active Instance IDs
    instances_status = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
    active_instance_ids = set()
    

    for reservation  in instances_status['Reservations']:
        for instance in reservation['Instances']:
            active_instance_ids.add(instance['InstanceId'])
     
            

    # Iterating to delete all the EBS Snapshots that are not associated with the Volumes and thoser are attached with Volumes but EC2 Instance is not running
    for snapshot in response['Snapshots']:
        snapshot_id = snapshot['SnapshotId']
        volume_id = snapshot.get('VolumeId')
        # print('Not get the volume')
        # Deleting Snapshots those are not attached with any volumes

        if not volume_id:
            print('Do Not get the volume')
            ec2.delete_snapshot(SnapshotId=snapshot_id)
            # print('Did Not get the volume')
            print(f'Deleted EBS Snapshot {snapshot_id} as it is not attached any volumes')
            
        else : 
            
            try:
                volume_response = ec2.describe_volumes(VolumeIds=[volume_id])
                # Deleting Snapshots those are attached with the Volumes but EC2 is not running
                if not volume_response['Volumes'][0]['Attachments']:
                    ec2.delete_snapshot(SnapshotId=snapshot_id)
                    print(f'Deleted EBS Snapshot {snapshot_id} as it is attached to the volume {volume_id} but EC2 is not running')

            except ec2.exceptions.ClientError as e:    
                # Deleting Snapshots if associated volumes did not found
                if e.response['Error']['Code'] == 'InvalidVolume.NotFound':
                    ec2.delete_snapshot(SnapshotId=snapshot_id)
                    print(f'Deleted EBS Snapshot {snapshot_id} as its associated volume did not found')
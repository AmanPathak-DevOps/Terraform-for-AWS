import json
import boto3
import datetime
from botocore.exceptions import ClientError
import pandas as pd

def lambda_handler(event, context):

    billing_client = boto3.client('ce')
    # getting dates (yyyy-MM-dd) and converting to string 
    today = datetime.date.today()
    yesterday = today - datetime.timedelta(days = 1) 
    str_today = str(today) 
    str_yesterday = str(yesterday)

    # get total cost for the previous day
    response_total = billing_client.get_cost_and_usage( 
       TimePeriod={ 
         'Start': str_yesterday,
         'End': str_today,
         #'Start': "2023-05-16",
        # 'End': "2023-05-17"
         },
       Granularity='DAILY', 
       Metrics=[ 'UnblendedCost',] 
    )

    total_cost = response_total["ResultsByTime"][0]['Total']['UnblendedCost']['Amount']
    print(total_cost)
    total_cost=float(total_cost)
    total_cost=round(total_cost, 3)
    total_cost = '$' + str(total_cost)

    # print the total cost
    print('Total cost for yesterday: ' + total_cost)

    # get detailed billing for individual resources
    response_detail = billing_client.get_cost_and_usage(
        TimePeriod={
           'Start': str_yesterday,
           'End': str_today,
        },
        Granularity='DAILY',
        Metrics=['UnblendedCost'],
        GroupBy=[
            {
                'Type': 'DIMENSION',
                'Key': 'SERVICE'
            },
            {
                'Type': 'DIMENSION',
                'Key': 'USAGE_TYPE'
            }
        ]
    )

    resources = {'Service':[],'Usage Type':[],'Cost':[]}

    for result in response_detail['ResultsByTime'][0]['Groups']:
        group_key = result['Keys']
        service = group_key[0]
        usage_type = group_key[1]
        cost = result['Metrics']['UnblendedCost']['Amount']
        cost=float(cost)
        cost=round(cost, 3)

        if cost > 0:
            cost = '$' + str(cost)
            resources['Service'].append(service)
            resources['Usage Type'].append(usage_type)
            resources['Cost'].append(cost)

    df = pd.DataFrame(resources)
    html_table = df.to_html(index=False)

    print(resources)        

    message = 'Cost of AWS training account for yesterday was' 

    html = """
            <html>
              <head>
                <style>
                  body {{
                    font-family: Arial, sans-serif;
                    color: white;
                    background-color: black;
                  }}
                  h2 {{
                    color: white;
                    font-size: 25px;
                    text-align: center;
                  }}
                  h1 {{
                    color: #333333;
                    font-size: 40px;
                    text-align: center;
                    background-color: yellow;
                  }}
                  p {{
                    color: white;
                    font-size: 30px;
                    line-height: 1.5;
                    margin-bottom: 20px;
                    text-align: center;
                  }}
                  p1 {{
                     font-size: 10px;
                     text-align: center;
                      margin-left: auto;
                     margin-right: auto;
                  }}
                </style>
              </head>
              <body>
                <p> Training Account report for the day {} </p>
                <h2> {} </h2>
                <h1> <strong> <em> {} </em></strong> </h1>
                <p1>{}</p1>
              </body>
            </html>
            """.format(str_yesterday,message,total_cost,html_table)



    ses_client = boto3.client('ses', region_name='us-east-1')

    message = {
        'Subject': {'Data': 'AWS training account cost report'},
        'Body': {'Html': {'Data': html}}
    }


    response = ses_client.send_email(
        Source='aman07pathak@gmail.com',
        Destination={'ToAddresses': [ 'aman.pathak@aitglobalinc.com']},
        Message=message
    )

    if today.weekday() == 4:
        print('week')
        week = today - datetime.timedelta(days = 7) 
        str_week = str(week)

        response_total = billing_client.get_cost_and_usage( 
           TimePeriod={ 
             'Start': str_week, 
             'End': str_today }, 
           Granularity='MONTHLY', 
           Metrics=[ 'UnblendedCost',] 
        )

        print(response_total)
        length=len(response_total["ResultsByTime"])
        print(length)

        if (length==2):
            total_cost_1 = response_total["ResultsByTime"][0]['Total']['UnblendedCost']['Amount']
            total_cost_2 = response_total["ResultsByTime"][1]['Total']['UnblendedCost']['Amount']
            total_cost_1=float(total_cost_1)
            total_cost_2=float(total_cost_2)
            total_cost = total_cost_1+total_cost_2
            total_cost=round(total_cost, 3)
            total_cost = '$' + str(total_cost)

            # print the total cost
            print('Total cost for the week: ' + total_cost)

            # get detailed billing for individual resources
            response_detail = billing_client.get_cost_and_usage(
                TimePeriod={
                    'Start': str_week,
                    'End': str_today
                },
                Granularity='MONTHLY',
                Metrics=['UnblendedCost'],
                GroupBy=[
                    {
                        'Type': 'DIMENSION',
                        'Key': 'SERVICE'
                    },
                    {
                        'Type': 'DIMENSION',
                        'Key': 'USAGE_TYPE'
                    }
                ]
            )

            resources = {'Service':[],'Usage Type':[],'Cost':[]}
            resources_1 = {'Service':[],'Usage Type':[],'Cost':[]}

            for result in response_detail['ResultsByTime'][0]['Groups']:
                group_key = result['Keys']
                service = group_key[0]
                usage_type = group_key[1]
                cost = result['Metrics']['UnblendedCost']['Amount']
                cost=float(cost)
                cost=round(cost, 3)

                if cost > 0:
                    cost = '$' + str(cost)
                    resources['Service'].append(service)
                    resources['Usage Type'].append(usage_type)
                    resources['Cost'].append(cost)

            for result in response_detail['ResultsByTime'][1]['Groups']:
                group_key = result['Keys']
                service = group_key[0]
                usage_type = group_key[1]
                cost = result['Metrics']['UnblendedCost']['Amount']
                cost=float(cost)
                cost=round(cost, 3)

                if cost > 0:
                    cost = '$' + str(cost)
                    resources_1['Service'].append(service)
                    resources_1['Usage Type'].append(usage_type)
                    resources_1['Cost'].append(cost)

            for key, value in resources_1.items():
                if key in resources:
                    resources[key] += value
                else:
                    resources[key] = value
        else:
            total_cost = response_total["ResultsByTime"][0]['Total']['UnblendedCost']['Amount']
            total_cost=float(total_cost)
            total_cost=round(total_cost, 3)
            total_cost = '$' + str(total_cost)

            # print the total cost
            print('Total cost for the week: ' + total_cost)

            # get detailed billing for individual resources
            response_detail = billing_client.get_cost_and_usage(
                TimePeriod={
                    'Start': str_week,
                    'End': str_today
                },
                Granularity='MONTHLY',
                Metrics=['UnblendedCost'],
                GroupBy=[
                    {
                        'Type': 'DIMENSION',
                        'Key': 'SERVICE'
                    },
                    {
                        'Type': 'DIMENSION',
                        'Key': 'USAGE_TYPE'
                    }
                ]
            )

            resources = {'Service':[],'Usage Type':[],'Cost':[]}

            for result in response_detail['ResultsByTime'][0]['Groups']:
                group_key = result['Keys']
                service = group_key[0]
                usage_type = group_key[1]
                cost = result['Metrics']['UnblendedCost']['Amount']
                cost=float(cost)
                cost=round(cost, 3)

                if cost > 0:
                    cost = '$' + str(cost)
                    resources['Service'].append(service)
                    resources['Usage Type'].append(usage_type)
                    resources['Cost'].append(cost)

        print(type(resources))

        df = pd.DataFrame(resources)
        html_table = df.to_html(index=False)

        print(resources)        

        message = 'Cost of AWS training account for the  was' 

        html = """
                <html>
                  <head>
                    <style>
                      body {{
                        font-family: Arial, sans-serif;
                        color: white;
                        background-color: black;
                      }}
                      h2 {{
                        color: white;
                        font-size: 25px;
                        text-align: center;
                      }}
                      h1 {{
                        color: #333333;
                        font-size: 40px;
                        text-align: center;
                        background-color: yellow;
                      }}
                      p {{
                        color: white;
                        font-size: 30px;
                        line-height: 1.5;
                        margin-bottom: 20px;
                        text-align: center;
                      }}
                      p1 {{
                         font-size: 10px;
                         text-align: center;
                          margin-left: auto;
                         margin-right: auto;
                      }}
                    </style>
                  </head>
                  <body>
                    <p> Training Account report for the week {} and {} </p>
                    <h2> {} </h2>
                    <h1> <strong> <em> {} </em></strong> </h1>
                    <p1>{}</p1>
                  </body>
                </html>
                """.format(str_week,str_today,message,total_cost,html_table)

        ses_client = boto3.client('ses', region_name='us-east-1')

        message = {
            'Subject': {'Data': 'AWS training account cost report'},
            'Body': {'Html': {'Data': html}}
        }

        response = ses_client.send_email(
            Source='aman07pathak@gmail.com',
            Destination={'ToAddresses': [ 'aman.pathak@aitglobalinc.com']},
            Message=message
        )

        print(response)

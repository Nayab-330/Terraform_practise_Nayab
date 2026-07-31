
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
#below is iam role policy for lambda execution role which allows lambda to assume the role and execute the function.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" #existing AWS managed policy for Lambda execution
}


resource "aws_lambda_function" "my_lambda" {
    function_name = "my_lambda_function"
    role          = aws_iam_role.lambda_role.arn   
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.12"
    timeout       = 900
    memory_size   = 128
    filename = "lambda_function.zip"

 source_code_hash = filebase64sha256("lambda_function.zip") #whenever the code in the ZIP file changes, this hash will change, and Terraform will know to update the Lambda function with the new code.

    #Without source_code_hash, Terraform might not detect when the code in the ZIP file has changed — meaning your Lambda might not update even after uploading a new ZIP.

    #This hash is a checksum that triggers a deployment.
}


# EventBridge Rule - Runs every 5 minutes
resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = "lambda-schedule"
  description         = "Trigger Lambda every 5 minutes"
  #schedule_expression = "rate(5 minutes)"
schedule_expression = "cron(0/5 * * * ? *)"
}

# Attach Lambda as target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.lambda_schedule.name
  arn  = aws_lambda_function.my_lambda.arn
}

# Allow EventBridge to invoke Lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
}







# ########3



# resource "aws_iam_role" "lambda_role" {
#   name = "lambda_execution_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "lambda.amazonaws.com"
#       }
#     }]
#   })
# }
# #custom policy

# resource "aws_iam_role_policy_attachment" "lambda_policy" {
#   role       = aws_iam_role.lambda_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" #existing AWS managed policy for Lambda execution
# }

# resource "aws_lambda_function" "my_lambda" {
#   function_name = "my_lambda_function"
#   role          =  aws_iam_role.lambda_role.arn
#   handler       = "lambda_function.lambda_handler"
#   runtime       = "python3.12"
#   timeout       = 900
#   memory_size   = 128
#   filename = "lambda_function.zip"

 
#   source_code_hash = filebase64sha256("lambda_function.zip") #whenever the code in the ZIP file changes, this hash will change, and Terraform will know to update the Lambda function with the new code.

#   #Without source_code_hash, Terraform might not detect when the code in the ZIP file has changed — meaning your Lambda might not update even after uploading a new ZIP.

#   #This hash is a checksum that triggers a deployment.
# }

# resource "aws_cloudwatch_event_rule" "lambda_schedule" {
#   name                = "lambda_schedule_rule"
#   description         = "Trigger Lambda every 5 minutes"
#   schedule_expression = "cron(0/5 * * * ? *)"
# }

# resource "aws_cloudwatch_event_target" "lambda_target" {
#   rule      = aws_cloudwatch_event_rule.lambda_schedule.name
#   target_id = "lambda-schedule-target"
#   arn       = aws_lambda_function.my_lambda.arn
# }

# resource "aws_lambda_permission" "allow_cloudwatch" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.my_lambda.function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
# }
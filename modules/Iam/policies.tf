resource "aws_iam_policy_attachment" "cloudwatch_policy" {
  name       = "cloudwatch-policy"
  roles      = [aws_iam_role.role_terraform.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}
resource "aws_iam_policy_attachment" "sns_policy" {
  name       = "sns-policy"
  roles      = [aws_iam_role.role_terraform.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}
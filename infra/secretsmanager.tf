resource "aws_secretsmanager_secret" "user_data_connection_string" {
  name        = "user-data-connection-string"
  description = "Connection string for User Data database"
}

resource "aws_secretsmanager_secret_version" "user_data_connection_string" {
  secret_id     = aws_secretsmanager_secret.user_data_connection_string.id
  secret_string = "Server=localhost;Database=aot_tests;User Id=root;Password=default123;"
}
resource "azuread_user" "bob" {
  user_principal_name = "${var.iam_user_name}@example.com"
  display_name        = "BOB"
  mail_nickname       = "bob"
  password            = "P@ssw0rd1234!"
}

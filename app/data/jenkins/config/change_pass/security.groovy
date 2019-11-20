import groovy.json.JsonOutput



// A bunch of security setup related tasks

//
// disable anonymous access
//
security.setAnonymousAccess(false)
log.info('Anonymous access disabled')

//
// Change default password
//
def user = security.securitySystem.getUser('admin')
user.setEmailAddress('jon-doe@example.com')
security.securitySystem.updateUser(user)
security.securitySystem.changePassword('admin','admin')
log.info('default password for admin changed')

log.info('Script security completed successfully')

//Return a JSON response containing our new Users for confirmation
return JsonOutput.toJson([user])
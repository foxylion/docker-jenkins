import jenkins.model.*
import hudson.security.*

def jenkins = Jenkins.getInstance()
jenkins.setSecurityRealm(new HudsonPrivateSecurityRealm(false))
jenkins.setAuthorizationStrategy(new GlobalMatrixAuthorizationStrategy())

def user = jenkins.getSecurityRealm().createAccount('admin', 'admin')
user.save()

jenkins.getAuthorizationStrategy().add(Jenkins.ADMINISTER, 'admin')
jenkins.save()

# Keycloak Carbon

A theme for Keycloak, based off IBM [Carbon Design](https://carbondesignsystem.com/), that was referenced from [GOV.UK](https://github.com/UKHomeOffice/keycloak-theme-govuk).

This is a continuation with tweaks for the Yipnyap Brand to [httpsOmkar](https://github.com/httpsOmkar/carbon-keycloak-theme)'s theme.

# Note
There's some elements (like the logo on the top-left) that is not following the Carbon Design System on purpose. Our brand requires that the logo is visible on all official pages on the top navbar either on the far left or center. You can change this behaviour in your Keycloak Realm and changing the display HTML field.

# Usage
To install on your own Keycloak Realm, you will first need to install Node.JS with NPM or Yarn. We'll assume you already have it installed. 

```
git clone https://github.com/ypnyp/kc-carbon.git
cd kc-carbon
```

Install dependencies
```
npm i
```

Then build the project and copy it into Keycloak. This will assume your Keycloak install is at `/opt/keycloak`.
```
npm run build
cp -r ./carbon /opt/keycloak/themes/carbon
```

If updating, you may have to run `rm -r /opt/keycloak/themes/carbon` first. If you run into issues, try restarting your Keycloak Instance before opening a Github Issue.

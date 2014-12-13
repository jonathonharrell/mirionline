Miri Online
===========

Before next minor release bump:
 - Terms opt-in for signup

Before next major release bump:
 - Able to log in, create character, see some amount of UI

## @todo

#### Research
 - Captcha, email verification or other bot / spam prevention
 - Clustering
 - Scale

#### Functionality (server side)
 - Add better session longevity [PR](https://github.com/DaftMonk/generator-angular-fullstack/pull/444/files)
 - Start on character select
 - More specs (specifically for client)
 - Add "showTutorials" flag to user model (part of joyride)
 - Add more logging fields to user record (lastLoggedIn, currentLoggedIn, IP address logging, timestamps)
   - Add hooks to save to those fields

#### Client stuff
 - Add "Joyride" to tutorial users around the create character unless user has passed tutorials
 - Specs for account section controllers
 - Terms of use and opt-in

#### Bugs
 - Logout should disconnect from socket

#### Design (styles)
 - Color Scheme

#### Assets (images)
 - Parralax background for auth views
 - Logo
 - Font

#### Thoughts
 - Get e2e tests back in action ? (low priority)

#### Long Term
 - Add social signup / login (Twitter / Facebook / Google+)
 - Two factor auth for local (email, SMS)
 - Admin tools to limit logins to beta users, and manage user accounts
 - Better prevention of abuse of forgot password form
 - Support section (account/customer service/help)
 - Email unsubscribe
   - Link in footer of non-transactional emails (use JWT for verification)
   - Option on settings page
   - receiveEmail flag for user model
   - Only applies to solicitation emails IE:
     - You haven't logged in for a while!
     - Check out this new content!
     - Other updates


## Tools and Accounts
 - Email: Sendgrid
 - Public issues: [here](https://github.com/jonathonharrell/mirionline-issues/issues)

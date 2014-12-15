Miri Online
===========

Before next minor release bump:
 - Character create ui

Before next major release bump:
 - Able to log in, create character, see some amount of UI

## @todo

#### Research
 - Captcha, email verification or other bot / spam prevention
 - Clustering with websockets / other scaling issues

#### Functionality (server side)
 - Start hooking up sockets to game engine
   - Game class should be aware of socket list

#### Client stuff
 - Add "Joyride" to tutorial users around the play ui unless character has passed tutorials
 - Character create
 - Specs for account section controllers
 - Sprite directive. Should store sprite positions and replace element with `<div></div>`

#### Bugs
 - n/a

#### Design
 - Color Scheme
 - Character create UI
 - Play UI

#### Assets
 - Parralax background for auth views
 - Logo
 - Font
 - Sprite sheet

#### Thoughts
 - Get e2e tests back in action ? (low priority)
 - Session longevity ?

#### Long Term
 - Add social signup / login (Twitter / Facebook / Google+)
 - Two factor auth for local (email, SMS)
 - Admin tools
   - "Beta mode" - limit logins to users flagged for beta use (may not need to be a clientside tool)
   - Manage user accounts and view details (IP logs, etc)
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
 - Remember me [PR](https://github.com/DaftMonk/generator-angular-fullstack/pull/444/files)
 - Log time logged in (played time)
 - Better IP/login logging for security


## Tools and Accounts
 - Email: Sendgrid
 - Public issues: [here](https://github.com/jonathonharrell/mirionline-issues/issues)
 - Domain: Namecheap, minimiri.com

Miri Online
===========

Before next patch release bump:
 - Tests for engine classes
 - Character class, should validate and send structure based on lists and rules for properties
 - Rename names tool to character creation setup tool

Before next minor release bump:
 - Able to log in, select/create character, see some amount of play UI

Before next major release (1.0):
 - Miri world done. Core features implemented in a meaningful way. UI done.
 - RC @ 2.0: Other planes done. Some additional features

## @todo

#### Research
 - Captcha, email verification or other bot / spam prevention
 - Clustering with websockets / other scaling issues

#### Functionality (server side)
 - Character creation options sent to client to build form

#### Client stuff
 - Add "Joyride" to tutorial users around the play ui unless character has passed tutorials
 - Specs for account section controllers
 - Sprite directive. Should store sprite positions and replace element with `<div></div>`

#### Bugs
 - n/a

#### Design
 - Color Scheme
 - Play UI

#### Assets
 - Parralax background for auth views
 - Logo
 - Font
 - Sprite sheet

#### Tools
 - First tool: Easily edit character creation options and descriptions

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

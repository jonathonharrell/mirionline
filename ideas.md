Blood and blood trails:
  art needed: four different 1x1 blood drop tiles
    two different 1x1 blood puddle tiles
    one 2x2 blood pool tile
  Bleeding may cause blood drop on tile
  
  This mechanic makes pvp or the idea of hunting someone much more fun
  
  Problems: lots of art required for a largely aesthetic feature

Paper doll (armor):
  To avoid having to create an unnecessary amount of art assets, paper doll armor will exist under the following conditions:
  Body - Heavy armor (show art to indicate player is wearing heavy armor)
  Body - Light armor (show art to indicate player is wearing light armor)
  Head - Masked (show art to indicate players face is concealed)
  Head - Hooded (show are to indicate players face is concealed)
  Head - Heavy armor (show art to indicate player is wearing a helmet)
  
  Problems: Still quite a lot of art assets; Might not show all the details players would like to know upon sight
  
Paper doll (holding):
  Paperdoll system should show items that the character is holding to allow player to have more details on what the character might do.
  Logic: 
    When facing north - render behind; render right on right; render left on left;
    When facing south - render in front; render left on right; render right on left;
    When facing east - render left behind; render right in front
    When facing west - render left in front; render right behind
    2h: render in center of character; 1h: render at hand wielded;
    reverse art depending on direction faced
  Only need one sprite for each item, render position affected by direction-facing. 
  Types of held items:
    Weapon - Sword, Polearm, Dagger, Bow, Crossbow, Axe, Blunt-weapon, 2h Sword, Gun, Wand, Staff
    Tool - Fishing rod, Shovel, Pickaxe, Net, Instrument
    Other - Shield, Torch, Lantern, Orb, Book
    Resource - Bundle (various resources), Wood, Stone
    
  Problems: Possibly a large amount of art assets required
    
Action bubble:
  Shows additional actions that might be harder to represent graphically. Only one action bubble may appear at a time.
  Actions represented: 
    Reloading (one animation for any ranged weapon)
    Eating/Drinking
    Collecting fish (in shallows)
    Sprinting
    Sitting/Laying/Sleeping (zzZZ)
  
Character sprites:
  Positions: Facing each of four directions: N S E & W
  Sprites are small enough that variations only need to be made for skin color and hair color
  Hair colors: Blonde, Brown, Black
  Skin: Light, Medium, Dark
  No need for m/f variations
  
  Problems: each position we add for character sprite mutliplies the amount of art needed for other assets
  
SFX:
  list of needed sound effects -
    Fishing - Reel sound, plop from lure landing in water
    Combat - Metal on metal sounds, flesh to flesh sounds, metal to flesh sounds
  
  Problems: This takes a lot of time, but each bit that we can add creates immersion, and is arguable easier then GFX.
  Tools needed: Microphone to record sounds.
  
LoS / Fog of war:
  MAY REMOVE OR REWORK ENTIRELY

  Logic: Carrying / using light source creates surrounding light and allows visuals slight behind and further in front during night time.
    Weather affects LoS/FoW.
    No light source makes vision only in front in dark areas.
  
  Problems: How to implement becomes an issue.
    If on client side - Too easy to hack.
    If on server side - May cause unneeded lag as entities are loaded only when in view of the character.
    
Pets:
  Two overarching types - Passive, Worker
  Passive pets hang about but don't do much but accompany the player
  Worker pets accomplish some job, mostly fighting alongside or tracking
  Some smaller pets may "perch" on the player and remain hidden for a time
  Examples of passive pets: Squirrel, Rabbit
  Examples of worker pets: Dog, Wolf, Boar
  
  List of obtainable passive pets (plus variants) (in reference to art assets, each art asset may be reused for different pets):
    Squirrel, Bird, Rabbit
  List of obtainable worker  pets (plus variants) (in reference to art assets, each art asset may be reused for different pets):
    Dog, Dog (armored), Hawk, Boar, Boar (armored)
  
  Problems: Each pet added needs at least 4 sprites, plus variants. Possibly a problem for art assets
  
Development tools:
  Each major feature in the game (and some minor ones) should have associated tools.
  
Fishing
  Several different methods - 
    Rod fishing: Near water, cast baited line, wait for splash particles, click to reel in (typical)
      Rarer fish are available through this method then others.
    Shallows: Different tools have different effectiveness - spear, net, bare hands (click fish-area to go into shallow-fishing mode, click to catch)
      Some rare objects, less garbage then other methods.
    Fishing boat: Large net, gather large numbers of fish.
      Most common fish available through this method. No rare fish.
    Explosives: Waterproof explosives may kill fish and float them to top of water for collection
      Most common fish available through this method. No rare fish.
      
  Some methods may recover oceanic "trash" left by other players.
  The ocean contains a table of materials and such that have been left there or destroyed there, and fishing through certain methods may collect those.
  
Diving
  Breathing apparatus quality increases depth. Dive for potential treasure.
  This is another means of recovering "trash" left by other players.
  
  Hazards?
  
Movement
  Walk, run, sprint (internal sprint guage, effected by encumbrance)
  Mounted walk, run, sprint (mount determines speed of each)
  Flying mount similar walk, run, sprint, but additionally contains a key for "liftoff", increases z position, then walk/run/sprint over certain obstacles
  Swimming (doesn't require separate animation, just ripple water effect)
  On boats: Movement on boat not restricted
  
  Problems: ?
  
Mounts
  Mount acquisition:
    Trained Horses (purchase from vendor), Wild Horses (capture and tame, see Taming)
  List of mounts: Horse
  List of flying mounts:
  Other vehicles:
  
Storage & Mobile Storage


Inventory and added capacity


Transporting large items


Social Features General
  Friends, Mail, "note" system, 
  
Tattoo System
  Interesting/relevant quote: "I remember a character in one campaign I played (I think it was in GURPS) who had no armour, and the only clothes they wore were ragged cloth trousers. However, she was covered head to toe in tattoos. Essentially, she was a mage hunter. Almost completely immune to magic, but next to 0 protection from physical attacks."
  
  Players can give aesthetic tattoos, and tattoos with passive effects. The caveat here is that they have a greater affect when visible.
  Meaning armor will hide body tattoos, masks and helmets that cover the fact would cover face and head tattoos, and that would cause the effect to disappear.
  
Death & Penalties
  
  
Bound Items
  
  
Unique Items


Chemistry
  The first and largest item here is that in this game it is very different then alchemy.
  Alchemy   = transmutation, make something into something else. More magical
  Chemistry = combination,   mix two or more things to make something different. More scientific

Alchemy
  See Chemistry for differences.
  Transmutation.
  Philosopher's Stone ?
  
Herbology


Mining


Language


Taming


Weaving


Tailoring


Woodcutting


Skinning


Tanning/Leatherwork


Realms
  The Miri    - the default world wherein all characters begin.
  The Shadow  - clone of the miri wherein the world is old and ruined. Dark, fog, undead, evil, technology
  The Birth   - clone of the miri wherein the world is young and wild. Beasts, dragons, magic, fae
  The Light   - the place where characters go upon death. Instanced puzzle mini-games for resurrection
  The Chaos   - a realm where the elements roam freely. Elementals, demons, angels, gods
  The Outside - the tutorial realm. Players start here as new characters and have limited options.
  
  Accessing the other realms:
  The Miri   is accessed by default at start of game after introduction in The Outside.
  The Shadow is accessed...
  The Birth  is accessed...
  The Light  is accessed upon player death. You return after completing the puzzle in spirit form and must recover your body to come back.
  The Chaos  is accessed...
  
Writing


Books


Notes


Mail


Farming


Instruments


Deities


Flora


Fauna


Dynamic Spawn System


Weather System


Buff/Debuff System


Damage System


Weapons


Major Cities/Factions


Races


Character Creation


The Skill Tree


Destructable Structures


Alignments


Crime


Guards / City Alarm System


Player-made Structures


Automated Defenses/NPC's in Player Made Structures/Player Made Factions


Shops/Vendors


Player Shops/Hired Vendors


Auction Houses


Trade


Logging Out
  Timer ?

Accounts


Update Queue (architecture)


Locales and Points of Interest
  Nivek's Brothel (promised Kevin I'd have a place in game)
  Dath (character) - ???
  

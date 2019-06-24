# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

influencers = [
  { 
    name: 'Zoe Rodriguez', 
    instagram: '@zoelivelovelift', 
    twitter: '@zoelivelovelift', 
    birth_date: Date.today - 24.years - 76.days, 
    signup_date: Date.today - 1.year - 194.days,
    workouts: [
      { 
        title: 'Booty Builder',
        description: 'Sculpt your glutes and lower body with this quick 25 minute booty workout',
        duration_mins: 25
      },
      {
        title: 'Booty Boost',
        description: 'Sculpt your glutes and lower body with this quick 20 minute booty workout',
        duration_mins: 20
      },
      {
        title: 'Lower Body Burn #1',
        description: 'Join Zoe in the first workout of her challenging and rewarding lower body burn series',
        duration_mins: 27
      },
      {
        title: 'Upper Body Shred #1',
        description: 'Join Zoe in her beginner based upper body workout! Just grab a set of dumbells to tackle this workout.',
        duration_mins: 19
      }
    ]
  },
  { 
    name: 'Whitney Johns', 
    instagram: '@whitneyjohns', 
    twitter: '@whitneyjohns', 
    birth_date: Date.today - 28.years - 161.days, 
    signup_date: Date.today - 1.year - 71.days,
    workouts: [
      { 
        title: 'Core Blast',
        description: 'Whitney Johns is here to blast your core in this 25 minute class',
        duration_mins: 25
      },
      {
        title: 'Kettle Bell Blast',
        description: 'This workout is perfect if you''re in a rush and don''t have time for the gym! Join me for a quick 20 minute workout that you can do anywhere',
        duration_mins: 18
      },
      {
        title: 'HIIT Blast',
        description: 'This is a high-intensity HIIT training. This class will get your blood pumping and have you burning plenty of calories. Get ready to feel the burn.',
        duration_mins: 23
      }
    ]
  },
  { 
    name: 'James Ellis', 
    instagram: '@jamesellisfit', 
    twitter: '@jamesellisfit', 
    birth_date: Date.today - 31.years - 247.days, 
    signup_date: Date.today - 2.years,
    workouts: [
      { 
        title: 'Upper Body Blowout',
        description: 'We''re hitting the full upper body in this workout. We''re talking arms, chest, back and abs. Grab your resistance bands and mat, and get ready to sweat.',
        duration_mins: 22
      },
      {
        title: 'Arm Blaster',
        description: 'Grab your resistance bands and prepare to give your arms a serious workout. Build those biceps and horse-shoe triceps in this 22 minute high-intensity interval and resistance training class.',
        duration_mins: 22
      }
    ]
  }
]

influencers.each do |i|
  influencer = Influencer.create(name: i[:name], instagram: i[:instagram], twitter: i[:twitter], birth_date: i[:birth_date], signup_date: i[:signup_date])
  i[:workouts].each do |w|
    Workout.create(influencer: influencer, title: w[:title], description: w[:description], duration_mins: w[:duration_mins], is_private: false)
  end
end

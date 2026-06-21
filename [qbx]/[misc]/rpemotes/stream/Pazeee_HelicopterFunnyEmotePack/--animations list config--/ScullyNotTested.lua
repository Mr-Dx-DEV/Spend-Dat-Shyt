SCULLY =
    {
        Label = 'Heli A Idle',
        Command = 'phelia',
        Animation = 'pazeee@helia@clip',
        Dictionary = 'pazeee@helia@animations',
        Options = {
            Flags = {
                Loop = true,
            },
        },
    },
    {
        Label = 'Heli B Idle Spin',
        Command = 'phelib',
        Animation = 'pazeee@helib@clip',
        Dictionary = 'pazeee@helib@animations',
        Options = {
            Flags = {
                Loop = true,
            },
        },
    },
    {
        Label = 'Heli C Random Spin',
        Command = 'phelic',
        Animation = 'pazeee@helic@clip',
        Dictionary = 'pazeee@helic@animations',
        Options = {
            Flags = {
                Loop = true,
            },
        },
    },
    {
        Label = 'Heli D Flee',
        Command = 'phelid',
        Animation = 'pazeee@helid@clip',
        Dictionary = 'pazeee@helid@animations',
        Options = {
            Flags = {
                -- Need Flag = 4194337,
            },
        },
    },
    {
        Label = 'Heli ZI Race Mode',
        Command = 'phelizi',
        Animation = 'pazeee@helizi@clip',
        Dictionary = 'pazeee@helizi@animations',
        Options = {
            Flags = {
                -- Need Flag = 4194337,
            },
        },
    },
    {
        Label = 'Heli E Struggle',
        Command = 'phelie',
        Animation = 'pazeee@helie@clip',
        Dictionary = 'pazeee@helie@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelif',
            },
        },
    },
    {
        Label = 'Heli F Struggle',
        Command = 'phelif',
        Animation = 'pazeee@helif@clip',
        Dictionary = 'pazeee@helif@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'phelie',
            },
            AttachTo = true,
            Bone = 24818,
            Pos = vector3(-0.300, 1.100, 0.000),
            Rot = vector3(0.000, 0.000, 90.000),
        },
    },
    {
        Label = 'Heli G Happy Dance',
        Command = 'phelig',
        Animation = 'pazeee@helig@clip',
        Dictionary = 'pazeee@helig@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelih',
            },
        },
    },
    {
        Label = 'Heli H Happy Dance',
        Command = 'phelih',
        Animation = 'pazeee@helih@clip',
        Dictionary = 'pazeee@helih@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'phelig',
            },
            AttachTo = true,
            Bone = 24818,
            Pos = vector3(-0.200, 0.000, -0.0400),
            Rot = vector3(0.000, 0.000, 90.000),
        },
    },
    {
        Label = 'Heli I Angry',
        Command = 'phelii',
        Animation = 'pazeee@helii@clip',
        Dictionary = 'pazeee@helii@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelij',
            },
        },
    },
    {
        Label = 'Heli J Angry',
        Command = 'phelij',
        Animation = 'pazeee@helij@clip',
        Dictionary = 'pazeee@helij@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'phelii',
            },
            AttachTo = true,
            Bone = 24818,
            Pos = vector3(-0.1900, 0.1000, 0.000),
            Rot = vector3(0.000, 0.000, 70.000),
        },
    },
    {
        Label = 'Heli K Hug Scared',
        Command = 'phelik',
        Animation = 'pazeee@helik@clip',
        Dictionary = 'pazeee@helik@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelil',
            },
        },
    },
    {
        Label = 'Heli L Hug Scared',
        Command = 'phelil',
        Animation = 'pazeee@helil@clip',
        Dictionary = 'pazeee@helil@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'phelik',
            },
            AttachTo = true,
            Bone = 24818,
            Pos = vector3(0.000, 0.1000, 0.000),
            Rot = vector3(0.000, 0.000, 0.000),
        },
    },
    {
        Label = 'Heli M Enjoy The View',
        Command = 'phelim',
        Animation = 'pazeee@helim@clip',
        Dictionary = 'pazeee@helim@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelin',
            },
        },
    },
    {
        Label = 'Heli N Enjoy The View',
        Command = 'phelin',
        Animation = 'pazeee@helin@clip',
        Dictionary = 'pazeee@helin@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'phelim',
            },
            AttachTo = true,
            Bone = 24818,
            Pos = vector3(-0.42000, -0.15000, 0.000),
            Rot = vector3(0.000, 0.000, -90.000),
        },
    },
    {
        Label = 'Heli O Boss High',
        Command = 'phelio',
        Animation = 'pazeee@helio@clip',
        Dictionary = 'pazeee@helio@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelip',
            },
        },
    },
    {
        Label = 'Heli P Boss High',
        Command = 'phelip',
        Animation = 'pazeee@helip@clip',
        Dictionary = 'pazeee@helip@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'phelio',
            },
            AttachTo = true,
            Bone = 11816,
            Pos = vector3(0.6300, -0.4800, 0.000),
            Rot = vector3(0.000, 0.000, -70.000),
        },
    },
    {
        Label = 'Heli Q Cowboy Enjoy',
        Command = 'pheliq',
        Animation = 'pazeee@heliq@clip',
        Dictionary = 'pazeee@heliq@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelir',
            },
        },
    },
    {
        Label = 'Heli R Cowboy Enjoy',
        Command = 'phelir',
        Animation = 'pazeee@helir@clip',
        Dictionary = 'pazeee@helir@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'pheliq',
            },
            AttachTo = true,
            Bone = 11816,
            Pos = vector3(0.3000, -0.1000, 0.000),
            Rot = vector3(0.000, 0.000, -80.000),
        },
    },
    {
        Label = 'Heli S Sit Up',
        Command = 'phelis',
        Animation = 'pazeee@helis@clip',
        Dictionary = 'pazeee@helis@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelit',
            },
        },
    },
    {
        Label = 'Heli T Sit Up',
        Command = 'phelit',
        Animation = 'pazeee@helit@clip',
        Dictionary = 'pazeee@helit@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'phelis',
            },
            AttachTo = true,
            Bone = 11816,
            Pos = vector3(-0.19000, 0.4400, 0.000),
            Rot = vector3(0.000, 0.000, 100.000),
        },
    },
    {
        Label = 'Heli U Head High',
        Command = 'pheliu',
        Animation = 'pazeee@heliu@clip',
        Dictionary = 'pazeee@heliu@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'pheliv',
            },
        },
    },
    {
        Label = 'Heli V Head High',
        Command = 'pheliv',
        Animation = 'pazeee@heliv@clip',
        Dictionary = 'pazeee@heliv@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'pheliu',
            },
            AttachTo = true,
            Bone = 11816,
            Pos = vector3(-0.87000, 0.900, -0.100),
            Rot = vector3(0.000, 0.000, -70.000),
        },
    },
    {
        Label = 'Heli W Pull Please Don't Go',
        Command = 'pheliw',
        Animation = 'pazeee@heliw@clip',
        Dictionary = 'pazeee@heliw@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelix',
            },
        },
    },
    {
        Label = 'Heli X Pull Please Don't Go',
        Command = 'phelix',
        Animation = 'pazeee@helix@clip',
        Dictionary = 'pazeee@helix@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'pheliw',
            },
            AttachTo = true,
            Bone = 11816,
            Pos = vector3(1.14000, 0.600, -0.0300),
            Rot = vector3(0.000, 0.000, -80.000),
        },
    },
    {
        Label = 'Heli Y Hold Front',
        Command = 'pheliy',
        Animation = 'pazeee@heliy@clip',
        Dictionary = 'pazeee@heliy@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'pheliz',
            },
        },
    },
    {
        Label = 'Heli Z Hold Front',
        Command = 'pheliz',
        Animation = 'pazeee@heliz@clip',
        Dictionary = 'pazeee@heliz@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'pheliy',
            },
            AttachTo = true,
            Bone = 11816,
            Pos = vector3(-1.42000, 0.100, 0.2200),
            Rot = vector3(0.000, 0.000, -80.000),
        },
    },
    {
        Label = 'Heli ZA Steal Box',
        Command = 'pheliza',
        Animation = 'pazeee@heliza@clip',
        Dictionary = 'pazeee@heliza@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelizb',
            },
        },
    },
    {
        Label = 'Heli ZB Steal Box',
        Command = 'phelizb',
        Animation = 'pazeee@helizb@clip',
        Dictionary = 'pazeee@helizb@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'pheliza',
            },
            Props = {
                {
                    Bone = 0,
                    Name = "hei_prop_heist_wooden_box",
                    Placement = {
                        vector3(-0.03, 0.180, -0.440),
                        vector3(0.000, 0.000, 0.000)
                    },
                },
            },
            AttachTo = true,
            Bone = 11816,
            Pos = vector3(-0.36000, 0.9900, -0.0400),
            Rot = vector3(0.000, 0.000, -70.000),
        },
    },
    {
        Label = 'Heli ZC Pointing A Gun',
        Command = 'phelizc',
        Animation = 'pazeee@helizc@clip',
        Dictionary = 'pazeee@helizc@animations',
        Options = {
            Flags = {
                Loop = true,
                -- Need Flag = 33
            },
            Shared = {
                OtherAnimation = 'phelizd',
            },
        },
    },
    {
        Label = 'Heli ZD Pointing A Gun',
        Command = 'phelizd',
        Animation = 'pazeee@helizd@clip',
        Dictionary = 'pazeee@helizd@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'phelizc',
            },
            AttachTo = true,
            Bone = 11816,
            Pos = vector3(-0.2000, 1.0400, 0.000),
            Rot = vector3(0.000, 0.000, -80.000),
        },
    },
    {
        Label = 'Heli ZE Best View!',
        Command = 'phelize',
        Animation = 'pazeee@helize@clip',
        Dictionary = 'pazeee@helize@animations',
        Options = {
            Flags = {
                -- Need Flag = 2
            },
            Shared = {
                OtherAnimation = 'phelizf',
            },
        },
    },
    {
        Label = 'Heli ZF Best View!',
        Command = 'phelizf',
        Animation = 'pazeee@helizf@clip',
        Dictionary = 'pazeee@helizf@animations',
        Options = {
            Shared = {
                OtherAnimation = 'phelize',
            },
            AttachTo = true,
            Bone = 11816,
            Pos = vector3(-0.4900, 1.0200, -0.0600),
            Rot = vector3(0.000, 0.000, -70.000),
        },
    },
    {
        Label = 'Heli ZH Carry Toys',
        Command = 'phelizh',
        Animation = 'pazeee@helizh@clip',
        Dictionary = 'pazeee@helizh@animations',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'phelizg',
            },
        },
    },
    {
        Label = 'Heli ZG Carry Toys',
        Command = 'phelizg',
        Animation = 'pazeee@helizg@clip',
        Dictionary = 'pazeee@helizg@animations',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'phelizh',
            },
            AttachTo = true,
            Bone = 24818,
            Pos = vector3(-0.0100, -0.1400, -0.300),
            Rot = vector3(0.000, 0.000, 0.000),
        },
    },
},
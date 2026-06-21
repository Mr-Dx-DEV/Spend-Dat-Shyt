
In-Game Shell Offset Creator (Developer Tool)

This tool is an offset creator used to generate offset positions required when creating shell interiors in Config.HouseShells.

It allows you to place interaction points (exit, management, wardrobe, storage, etc.) directly inside a spawned shell and automatically generate offset data relative to the shell entity.

The generated offsets are then used in Config.HouseShells for correct shell positioning and interaction logic.

You can view existing examples in our configuration, for example rtx_housing_shell_1.
Simply copy the entire generated data exactly as shown in the output and paste it into your Config.HouseShells entry.

Example reference:
[https://imagedelivery.net/wQ0nnHU7kgqHqLZ2Tkf-0w/838d5c8d-a08b-4a4d-93b9-e63a5a1fa500/public](https://imagedelivery.net/wQ0nnHU7kgqHqLZ2Tkf-0w/838d5c8d-a08b-4a4d-93b9-e63a5a1fa500/public)

---

Commands:

Points:
/addpoint exit
/addpoint management
/addpoint wardrobe
/addpoint storage
/addpoint cook
/addpoint shower
/addpoint sink
/addpoint clean

Shell Spawn:
/spawnshell shellname

Example:
/spawnshell shell_michael

Noclip:
/noclipshell

---

Important Information:

All commands automatically output generated data into the F8 console.

You must manually copy the generated output from the F8 console and paste it into the configuration file in order to save the changes.

---

DISCLAIMER (IMPORTANT):

THIS IS A DEVELOPER RESOURCE.

This resource is intended ONLY for development and configuration purposes.

It should NEVER be used on a live or public server.

Running this resource on a public server may cause:

* performance issues
* unintended shell spawns
* data inconsistencies
* security risks

Always use this tool only in a development environment or on a local test server.



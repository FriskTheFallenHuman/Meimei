{
    "id": "c709504b-000e-46db-926f-384d5f20f5c9",
    "modelName": "GMExtension",
    "mvc": "1.2",
    "name": "UnboxedGMS2",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        
    ],
    "androidProps": false,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": 194,
    "date": "2018-27-22 01:08:40",
    "description": "",
    "exportToGame": true,
    "extensionName": "",
    "files": [
        {
            "id": "5bd468af-8915-4502-92ca-06c78277c2c7",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                {
                    "id": "04250d6a-4156-477b-b7e0-9b98970a33db",
                    "modelName": "GMProxyFile",
                    "mvc": "1.0",
                    "TargetMask": 7,
                    "proxyName": "libue.so"
                },
                {
                    "id": "881afa7a-6951-44dc-bde8-fb1ea006ea79",
                    "modelName": "GMProxyFile",
                    "mvc": "1.0",
                    "TargetMask": 1,
                    "proxyName": "libue.dylib"
                }
            ],
            "constants": [
                
            ],
            "copyToTargets": 194,
            "filename": "ue.dll",
            "final": "",
            "functions": [
                {
                    "id": "20e076a1-e11c-4c5a-8530-c00c86c478e7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "file_text_open_read_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_text_open_read_ue",
                    "returnType": 1
                },
                {
                    "id": "95b24579-affd-481a-b314-61aa71909f68",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "file_text_eof_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_text_eof_ue",
                    "returnType": 2
                },
                {
                    "id": "70188ada-e7a0-48ac-b5ac-8a679186566b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "file_text_readln_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_text_readln_ue",
                    "returnType": 1
                },
                {
                    "id": "53aa03d0-25d0-424f-b439-bc9de7665b4e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "file_text_close_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_text_close_ue",
                    "returnType": 2
                },
                {
                    "id": "26d1ed1d-0463-450d-96e8-6af918481546",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "working_directory_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "working_directory_ue",
                    "returnType": 1
                },
                {
                    "id": "7ddd5ae9-e3e9-436d-b02a-14b6122ab61f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "directory_exists_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "directory_exists_ue",
                    "returnType": 2
                },
                {
                    "id": "bb93eb4b-207e-49a0-9278-caccb106abdd",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "directory_delete_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "directory_delete_ue",
                    "returnType": 2
                },
                {
                    "id": "6613af12-dd37-464d-9e38-6e6e73be8f38",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "directory_create_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "directory_create_ue",
                    "returnType": 2
                },
                {
                    "id": "a441813d-24b7-4c65-97f4-8ec60ff5258b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_rename_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "directory_rename_ue",
                    "returnType": 1
                },
                {
                    "id": "3ea5b396-7503-4bfc-8908-e6f43b183668",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "file_exists_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_exists_ue",
                    "returnType": 2
                },
                {
                    "id": "571c5bc5-3431-41ce-b2ef-701c961a8535",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "file_delete_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_delete_ue",
                    "returnType": 2
                },
                {
                    "id": "6dfea74b-b8cc-4ee6-9a5b-51b4ee079e44",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_rename_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_rename_ue",
                    "returnType": 2
                },
                {
                    "id": "54efc619-b981-45fa-a088-6e1aa1dc82ed",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_copy_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_copy_ue",
                    "returnType": 2
                },
                {
                    "id": "a79a17b3-1721-4163-b306-458af47d95f9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_text_writeln_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_text_writeln_ue",
                    "returnType": 2
                },
                {
                    "id": "a9d782e9-0cc8-462d-ab52-046705b3ecae",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "file_text_open_write_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_text_open_write_ue",
                    "returnType": 1
                },
                {
                    "id": "861c3858-beab-4c34-bc0a-5146d0a7566b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "file_text_open_append_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_text_open_append_ue",
                    "returnType": 1
                },
                {
                    "id": "fdb70673-e186-464f-a6f3-251e6042da16",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "file_find_first_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_find_first_ue",
                    "returnType": 1
                },
                {
                    "id": "99191875-5b0a-4bc7-86e7-24d9fe38a195",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "file_find_next_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_find_next_ue",
                    "returnType": 1
                },
                {
                    "id": "fab08b02-fbcf-4ea9-80b4-e16d65c091e8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "file_find_attributes_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_find_attributes_ue",
                    "returnType": 2
                },
                {
                    "id": "7c31572c-1e71-44bf-8019-0c30718ae0da",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "file_find_close_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_find_close_ue",
                    "returnType": 2
                },
                {
                    "id": "e41eeab6-9fa5-49de-a58f-2ed0edc56606",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "file_find_size_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "file_find_size_ue",
                    "returnType": 2
                },
                {
                    "id": "9b0ddef7-ccde-4be3-b09d-d9e816faf3a6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "environment_get_variable_ue",
                    "help": "",
                    "hidden": false,
                    "kind": 1,
                    "name": "environment_get_variable_ue",
                    "returnType": 1
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                "3ea5b396-7503-4bfc-8908-e6f43b183668",
                "571c5bc5-3431-41ce-b2ef-701c961a8535",
                "6dfea74b-b8cc-4ee6-9a5b-51b4ee079e44",
                "54efc619-b981-45fa-a088-6e1aa1dc82ed",
                "20e076a1-e11c-4c5a-8530-c00c86c478e7",
                "a9d782e9-0cc8-462d-ab52-046705b3ecae",
                "861c3858-beab-4c34-bc0a-5146d0a7566b",
                "95b24579-affd-481a-b314-61aa71909f68",
                "a79a17b3-1721-4163-b306-458af47d95f9",
                "53aa03d0-25d0-424f-b439-bc9de7665b4e",
                "26d1ed1d-0463-450d-96e8-6af918481546",
                "7ddd5ae9-e3e9-436d-b02a-14b6122ab61f",
                "bb93eb4b-207e-49a0-9278-caccb106abdd",
                "6613af12-dd37-464d-9e38-6e6e73be8f38",
                "a441813d-24b7-4c65-97f4-8ec60ff5258b",
                "fdb70673-e186-464f-a6f3-251e6042da16",
                "70188ada-e7a0-48ac-b5ac-8a679186566b",
                "99191875-5b0a-4bc7-86e7-24d9fe38a195",
                "fab08b02-fbcf-4ea9-80b4-e16d65c091e8",
                "e41eeab6-9fa5-49de-a58f-2ed0edc56606",
                "7c31572c-1e71-44bf-8019-0c30718ae0da",
                "9b0ddef7-ccde-4be3-b09d-d9e816faf3a6"
            ],
            "origname": "",
            "uncompress": false
        },
        {
            "id": "28985e86-48ff-4761-bc19-ef42114627de",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 0,
            "filename": "ue.pas",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 4,
            "order": [
                
            ],
            "origname": "",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": false,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosdelegatename": null,
    "iosplistinject": "",
    "license": "",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "options": null,
    "optionsFile": "options.json",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "supportedTargets": 194,
    "tvosProps": false,
    "tvosSystemFrameworkEntries": [
        
    ],
    "tvosThirdPartyFrameworkEntries": [
        
    ],
    "tvosclassname": "",
    "tvosdelegatename": null,
    "tvosmaccompilerflags": "",
    "tvosmaclinkerflags": "",
    "tvosplistinject": "",
    "version": "0.1.4"
}
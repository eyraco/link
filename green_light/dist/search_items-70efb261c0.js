searchNodes=[{"doc":"Defines an authorization module. When used, the authorization module expects a list of possible roles. An authorization module defines all the permissions with their role mappings. Permissions are defined by using the grant_* helpers ( GreenLight.Permissions.grant_access/2 , GreenLight.Permissions.grant_actions/2 ).","ref":"GreenLight.html","title":"GreenLight","type":"module"},{"doc":"Helper functions to check if a given user can access / invoke something.","ref":"GreenLight.Access.html","title":"GreenLight.Access","type":"module"},{"doc":"","ref":"GreenLight.Access.html#can?/3","title":"GreenLight.Access.can?/3","type":"function"},{"doc":"","ref":"GreenLight.AuthorizationNode.html","title":"GreenLight.AuthorizationNode","type":"protocol"},{"doc":"","ref":"GreenLight.AuthorizationNode.html#id/1","title":"GreenLight.AuthorizationNode.id/1","type":"function"},{"doc":"","ref":"GreenLight.AuthorizationNode.html#t:t/0","title":"GreenLight.AuthorizationNode.t/0","type":"type"},{"doc":"","ref":"GreenLight.Config.html","title":"GreenLight.Config","type":"module"},{"doc":"","ref":"GreenLight.Config.html#repo!/1","title":"GreenLight.Config.repo!/1","type":"function"},{"doc":"","ref":"GreenLight.Config.html#role_assignment_schema!/1","title":"GreenLight.Config.role_assignment_schema!/1","type":"function"},{"doc":"","ref":"GreenLight.Config.html#roles!/1","title":"GreenLight.Config.roles!/1","type":"function"},{"doc":"Query functions around role assignments.","ref":"GreenLight.Ecto.Query.html","title":"GreenLight.Ecto.Query","type":"module"},{"doc":"","ref":"GreenLight.Ecto.Query.html#assign_role/5","title":"GreenLight.Ecto.Query.assign_role/5","type":"function"},{"doc":"","ref":"GreenLight.Ecto.Query.html#list_principals/3","title":"GreenLight.Ecto.Query.list_principals/3","type":"function"},{"doc":"","ref":"GreenLight.Ecto.Query.html#list_roles/4","title":"GreenLight.Ecto.Query.list_roles/4","type":"function"},{"doc":"","ref":"GreenLight.Ecto.Query.html#query_node_ids/2","title":"GreenLight.Ecto.Query.query_node_ids/2","type":"function"},{"doc":"","ref":"GreenLight.Ecto.Query.html#query_role_assignments/2","title":"GreenLight.Ecto.Query.query_role_assignments/2","type":"function"},{"doc":"","ref":"GreenLight.Ecto.Query.html#remove_role!/5","title":"GreenLight.Ecto.Query.remove_role!/5","type":"function"},{"doc":"A role assignment entity is used to assign a role to a principal on a specific entity.","ref":"GreenLight.Ecto.RoleAssignment.html","title":"GreenLight.Ecto.RoleAssignment","type":"module"},{"doc":"","ref":"GreenLight.Ecto.RoleAssignment.html#green_light_role_assignment_fields/1","title":"GreenLight.Ecto.RoleAssignment.green_light_role_assignment_fields/1","type":"macro"},{"doc":"The Live module enables automatic authorization checks for LiveViews.","ref":"GreenLight.Live.html","title":"GreenLight.Live","type":"behaviour"},{"doc":"","ref":"GreenLight.Live.html#c:get_authorization_context/3","title":"GreenLight.Live.get_authorization_context/3","type":"callback"},{"doc":"This is module that automates the loading of entities based on path parameters. It is used by the authorization system to enforce access permissions against the loaded entities.","ref":"GreenLight.Loaders.html","title":"GreenLight.Loaders","type":"module"},{"doc":"","ref":"GreenLight.Loaders.html#call/2","title":"GreenLight.Loaders.call/2","type":"function"},{"doc":"Create a loader function using common Phoenix patterns. It assumes that the parameter is named id and when used as part of a nested resource setup it will be key _id. It can thus be used like this: defloader(:study, &amp;Link.Studies.get_study!/1)","ref":"GreenLight.Loaders.html#defloader/2","title":"GreenLight.Loaders.defloader/2","type":"macro"},{"doc":"","ref":"GreenLight.Loaders.html#entities/1","title":"GreenLight.Loaders.entities/1","type":"function"},{"doc":"","ref":"GreenLight.Loaders.html#entity_loader/2","title":"GreenLight.Loaders.entity_loader/2","type":"macro"},{"doc":"","ref":"GreenLight.Loaders.html#init/1","title":"GreenLight.Loaders.init/1","type":"function"},{"doc":"","ref":"GreenLight.Loaders.html#load_entities/2","title":"GreenLight.Loaders.load_entities/2","type":"function"},{"doc":"The permission map holds a mapping of permissions to roles. The permission map is intended to be an implementation detail of the authorization framework. Convenience functions to build it are provided in other modules.","ref":"GreenLight.PermissionMap.html","title":"GreenLight.PermissionMap","type":"module"},{"doc":"Returns wheter or not a the given set of roles should be allowed for the given permission.","ref":"GreenLight.PermissionMap.html#allowed?/3","title":"GreenLight.PermissionMap.allowed?/3","type":"function"},{"doc":"Add a mapping for the given role and permission if does not already exist.","ref":"GreenLight.PermissionMap.html#grant/3","title":"GreenLight.PermissionMap.grant/3","type":"function"},{"doc":"","ref":"GreenLight.PermissionMap.html#list_permission_assignments/1","title":"GreenLight.PermissionMap.list_permission_assignments/1","type":"function"},{"doc":"Merge two permission maps. The result of the merge is a permission map for which a permission that is available in either (or both) maps has the combined roles of both permission maps.","ref":"GreenLight.PermissionMap.html#merge/2","title":"GreenLight.PermissionMap.merge/2","type":"function"},{"doc":"","ref":"GreenLight.PermissionMap.html#new/0","title":"GreenLight.PermissionMap.new/0","type":"function"},{"doc":"","ref":"GreenLight.PermissionMap.html#new/1","title":"GreenLight.PermissionMap.new/1","type":"function"},{"doc":"This constructor is here to appease Dialyzer when a PermissionMap is used as a module attribute.","ref":"GreenLight.PermissionMap.html#new_t/1","title":"GreenLight.PermissionMap.new_t/1","type":"function"},{"doc":"Return a MapSet of roles for a given permission. This always returns a MapSet (might be empty).","ref":"GreenLight.PermissionMap.html#roles/2","title":"GreenLight.PermissionMap.roles/2","type":"function"},{"doc":"","ref":"GreenLight.PermissionMap.html#t:permission/0","title":"GreenLight.PermissionMap.permission/0","type":"type"},{"doc":"","ref":"GreenLight.PermissionMap.html#t:role/0","title":"GreenLight.PermissionMap.role/0","type":"type"},{"doc":"","ref":"GreenLight.PermissionMap.html#t:role_enum/0","title":"GreenLight.PermissionMap.role_enum/0","type":"type"},{"doc":"","ref":"GreenLight.PermissionMap.html#t:role_list/0","title":"GreenLight.PermissionMap.role_list/0","type":"type"},{"doc":"","ref":"GreenLight.PermissionMap.html#t:role_set/0","title":"GreenLight.PermissionMap.role_set/0","type":"type"},{"doc":"","ref":"GreenLight.PermissionMap.html#t:t/0","title":"GreenLight.PermissionMap.t/0","type":"opaque"},{"doc":"The permissions module provides several functions that create permission strings and GreenLight.PermissionMap s.","ref":"GreenLight.Permissions.html","title":"GreenLight.Permissions","type":"module"},{"doc":"","ref":"GreenLight.Permissions.html#access_permission/1","title":"GreenLight.Permissions.access_permission/1","type":"function"},{"doc":"","ref":"GreenLight.Permissions.html#action_permission/2","title":"GreenLight.Permissions.action_permission/2","type":"function"},{"doc":"","ref":"GreenLight.Permissions.html#actions_permission_map/2","title":"GreenLight.Permissions.actions_permission_map/2","type":"function"},{"doc":"","ref":"GreenLight.Permissions.html#grant/2","title":"GreenLight.Permissions.grant/2","type":"function"},{"doc":"","ref":"GreenLight.Permissions.html#grant/3","title":"GreenLight.Permissions.grant/3","type":"function"},{"doc":"","ref":"GreenLight.Permissions.html#grant_access/2","title":"GreenLight.Permissions.grant_access/2","type":"macro"},{"doc":"","ref":"GreenLight.Permissions.html#grant_actions/2","title":"GreenLight.Permissions.grant_actions/2","type":"macro"},{"doc":"","ref":"GreenLight.Permissions.html#setup_permission_map/1","title":"GreenLight.Permissions.setup_permission_map/1","type":"function"},{"doc":"This Plug validates the permissions before the request is allowed to proceed.","ref":"GreenLight.Plug.html","title":"GreenLight.Plug","type":"behaviour"},{"doc":"","ref":"GreenLight.Plug.html#call/2","title":"GreenLight.Plug.call/2","type":"function"},{"doc":"","ref":"GreenLight.Plug.html#init/1","title":"GreenLight.Plug.init/1","type":"function"},{"doc":"","ref":"GreenLight.Plug.html#c:load_entities/1","title":"GreenLight.Plug.load_entities/1","type":"callback"},{"doc":"The principal is used as a representation for any person / thing that can interact with the system. For more information see the Wikipedia article on principals .","ref":"GreenLight.Principal.html","title":"GreenLight.Principal","type":"protocol"},{"doc":"","ref":"GreenLight.Principal.html#id/1","title":"GreenLight.Principal.id/1","type":"function"},{"doc":"","ref":"GreenLight.Principal.html#roles/1","title":"GreenLight.Principal.roles/1","type":"function"},{"doc":"","ref":"GreenLight.Principal.html#t:t/0","title":"GreenLight.Principal.t/0","type":"type"},{"doc":"Green Light The Green Light framework is an authorization system that has the following goals: Secure by default: deny by default, require explicit authorizations grants Rely on automation, not discipline Clear auditing (understandable by stakeholders) Defense in depth: limit impact of security flaws by having several layers of protection The authorization system is comprised of several parts that work together to provide this functionality. At the core of the system there is Role Based Access Control (RBAC).","ref":"readme.html","title":"Green Light","type":"extras"},{"doc":"This system makes use of the following terminology. Permission A permission is a unique operation in the system. The application code that needs protection only works in terms of permissions. It is up to the authorization system to determine if the current user has the required permission. Entity Anything that can be accessed. The concrete implementation of this concept is an Ecto struct. Principal The principal is another name for user. It is given a distinct name since it can also be used to represent other authenticated systems. An example of this is an authorized application that acts on a users behalf. By making this a distinct concept it allows those kind of applications to operate with a subset of permissions. Role A role is an Elixir atom that maps on to a set of permissions. Permission Map The permission map ( GreenLight.PermissionMap ) is the datastructure which is used to map roles to permissions. Role Assignment A role assignment ( GreenLight.RoleAssignment ) registers the assignment of a role to a principal on a specific entity. This is what makes having local roles possible.","ref":"readme.html#terminology","title":"Green Light - Terminology","type":"extras"},{"doc":"Entity Loaders The GreenLight.Plug authorization module needs entities to enforce it's access rules. The entity loaders are responsible for taking Plug path_param and returning the entities. Authorization The GreenLight.Plug automatically enforces permission checks for all controller actions.","ref":"readme.html#plug-middleware","title":"Green Light - Plug Middleware","type":"extras"},{"doc":"Phoenix integration is available to make usage of the authorization system convenient. Controller Action Access Management All Phoenix controllers are automatically protected by the Plug middleware. Access to actions is denied unless a principal has sufficient roles to access the action. Each action is a seperate permission. Without a mapping of permissions to roles all access is denied. The GreenLight.Permissions.grant_actions/2 helper macro is provided to setup such a mapping. View Helpers The Phoenix views are extended with the GreenLight.can?/3 helper. This allows for easy checking of permissions within a temlate.","ref":"readme.html#phoenix-integration","title":"Green Light - Phoenix Integration","type":"extras"},{"doc":"The system comes with several mix tasks to inspect the state of the authorization system. Permissions The mix grlt.perms task shows a table of all permissions that have been defined with their associated roles. All permissions and roles are sorted alphabetically.","ref":"readme.html#mix-tasks","title":"Green Light - Mix Tasks","type":"extras"}]
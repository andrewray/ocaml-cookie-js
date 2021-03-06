(** Simple get/set cookie routines for js_of_ocaml.
 
    Based on javascript code at http://www.quirksmode.org/js/cookies.html *)

(** [set name value] creates (or replaces) a cookie.

    [days] sets the expiry date days in the future.  By default it is not set 
    and should be destroyed when the browser is closed.

    [path] sets the domain of the cookie and defaults to '/'. *)
val set : ?days:float -> ?path:string -> string -> string -> unit

(** get value of cookie with given name *)
val get : string -> string option

(** remove cookie *)
val remove : string -> unit



(* need GMT string format for cookies *)
class type date_ex = object
  inherit Js.date
  method toGMTString : Js.js_string Js.t Js.meth
end
let date_ex : date_ex Js.t Js.constr = Js.Unsafe.global##_Date
let one_day = 24. *. 60. *. 60. *. 1000.

let set ?days ?(path="/") name value = 
  let expires = 
    match days with
    | None -> ""
    | Some(days) -> 
      (* calculate the expiry date 'day' in the future *)
      let date = jsnew date_ex() in
      let _ = date##setTime( date##getTime() +. (days *. one_day) ) in
      "; expires=" ^ (Js.to_string date##toGMTString())
  in
  let cookie = name ^ "=" ^ value ^ expires ^ "; path=" ^ path in
  Dom_html.document##cookie <- Js.string cookie

let get name = 
  let name' = (Js.string name)##concat(Js.string "=") in
  let ca = Js.str_array (Dom_html.document##cookie##split(Js.string ";")) in
  (* drop spaces at start of the string *)
  let rec drop_spaces s = 
    if Js.to_string s##charAt(0) = " " then 
      drop_spaces s##substring(1, s##length)
    else s
  in
  (* search through array of cookies to find the one we need *)
  let rec iter i = 
    match Js.Optdef.to_option (Js.array_get ca i) with
    | None -> None
    | Some(c) ->
      let c = drop_spaces c in
      if c##indexOf(name') = 0 then 
        Some(Js.to_string c##substring(name'##length, c##length))
      else iter (i+1)
  in
  iter 0
  
(* remove cookie *)
let remove name = set ~days:(-1.) name ""

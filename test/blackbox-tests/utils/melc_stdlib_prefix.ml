open Stdune

let command cmd args =
  let p = Unix.open_process_args_in cmd (Array.of_list (cmd :: args)) in
  let output = Io.read_all p in
  match Unix.close_process_in p with
  | WEXITED n when n = 0 -> Ok output
  | WEXITED n -> Error n
  | WSIGNALED _ | WSTOPPED _ -> assert false

let () =
  let where = command "melc" [ "--where" ] in
  match where with
  | Error n ->
    Format.eprintf "error: %d@." n;
    exit 2
  | Ok where ->
    let parts =
      Bin.parse_path where
      |> List.map ~f:(fun part ->
             Format.asprintf "/MELC_STDLIB=%s" (Path.to_string part))
    in
    Format.printf "%s" (String.concat parts ~sep:":")

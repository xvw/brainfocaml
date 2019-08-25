(** Result Helper *)

type 'a t = ('a, Error.t) result

(** {2 Builders} *)

val ok : 'a -> 'a t
val error : Error.t -> 'a t

(** {2 API} *)

val map : ('a -> 'b) -> 'a t -> 'b t
val bind : ('a -> 'b t) -> 'a t -> 'b t

(** {2 Infix} *)

module Infix : sig
  val ( >|= ) : 'a t -> ('a -> 'b) -> 'b t
  val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t
end

include module type of Infix

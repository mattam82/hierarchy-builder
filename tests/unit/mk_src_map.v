From HB Require Import structures.

HB.mixin Record is_foo P A := { op : P -> A -> A }.
HB.mixin Record is_foo' P A := { op : P -> A -> A }.

HB.instance Definition list_foo P := is_foo.Build P (list P) (fun _ x => x).

HB.instance Definition list_foo' P A := is_foo.Build P (list A) (fun _ x => x).
Check list_foo'.
Check list_foo.

Elpi Query HB.structure lp:{{

has-mixin-instance->mixin-src (has-mixin-instance (cs-gref{{:gref list}}) {{:gref is_foo.axioms_}} {{:gref list_foo}}) MS,
    {{:gref list}} = indt List, {{:gref list_foo}} = const ListFoo,
    % The universe instances of list and list_foo are fresh
    MS = (pi a b aty diag \
        mixin-src (app [global (indt List) _, b]) ({{:gref is_foo.axioms_}}) (app [global (const ListFoo) _, a])
            :- [coq.typecheck a aty diag, coq.unify-eq a b ok])
}}.

Elpi Query HB.structure lp:{{

has-mixin-instance->mixin-src (has-mixin-instance (cs-gref{{:gref list}}) {{:gref is_foo.axioms_}} {{:gref list_foo'}}) MS',
{{:gref list}} = indt List, {{:gref list_foo'}} = const ListFoo',
MS' = (pi p a b aty diag \
    mixin-src (app [global (indt List) _, b]) {{:gref is_foo.axioms_}} (app [global (const ListFoo') _, p,a])
        :- [coq.typecheck a aty diag, coq.unify-eq a b ok]).
}}.
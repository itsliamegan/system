# Helios conventions

These apply to applications built on Helios. `python.md` covers the Python.

## Models

- Write a model's finders, and the operations on a set of its records such as
  arranging and moving, as class methods that take the store as their first
  argument. Do not gather them into a collection class that holds a store.

## Views

- Put a component in the view directory of the concept it shows, as Rails
  keeps a partial with its resource: `BoardChip` is `boards/chip`. Keep the
  components that show no domain concept, such as a confirm button, in
  `components/`.
- Show each variant of a sum type through its own component, and pick the
  component in Python with a match on the variant. Templates do not branch on
  variants.

Trivial repro case for a `uv` bug (https://github.com/astral-sh/uv/issues/1661) where uv and pip diverge. There are two PEP420 packages, `ns1.package1` and `ns2.package2` (which depends on the former). `pip install -e` one by one works fine, but `uv pip install -e` fails on `ns2.package2`:

# pip-test.sh
See that `pip install -e` is able to resolve the `ns1.package1` dependency; it's already editable-installed into the venv so it's trivially satisfied.

<img width="1292" alt="Screenshot 2024-02-18 at 2 31 15 PM" src="https://github.com/charlesnicholson/uv-pep420-bug/assets/3010295/4774b63b-0bfb-493e-851b-2d173d80236a">

# uv-test.sh
See that `uv pip install -e` doesn't recognize that `ns1.package1` is already installed; perhaps something with converting the dot to a dash?

<img width="940" alt="Screenshot 2024-02-18 at 2 30 21 PM" src="https://github.com/charlesnicholson/uv-pep420-bug/assets/3010295/b09757cc-389a-4508-a9a7-6c87e57a9ee1">

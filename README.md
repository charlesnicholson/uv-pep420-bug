Trivial repro case for a bug where uv and pip diverge. There are two PEP420 packages, `ns1.package1` and `ns2.package2` (which depends on the former). `pip install -e` one by one works fine, but `uv pip install -e` fails on `ns2.package2`:

pip-test.sh:

<img width="1270" alt="Screenshot 2024-02-18 at 12 53 27 PM" src="https://github.com/charlesnicholson/uv-pep420-bug/assets/3010295/0b55fe63-3d2b-4cc9-a5f3-5cc97784b449">
See that `pip install -e` is able to resolve the `ns1.package1` dependency; it's already editable-installed into the venv so it's trivially satisfied.

uv-test.sh:

<img width="726" alt="Screenshot 2024-02-18 at 12 50 39 PM" src="https://github.com/charlesnicholson/uv-pep420-bug/assets/3010295/cd8654e2-e58e-49a2-9613-4be8ac7934df">
See that `uv pip install -e` doesn't recognize that `ns1.package1` is already installed; perhaps something with converting the dot to a dash?

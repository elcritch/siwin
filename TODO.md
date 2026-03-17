# TODO

## Next Steps
- [ ] Cocoa: make top-level `size=` and `pos=` use the same backing-pixel coordinate model as `window.size`, mouse events, and popup placement.
- [ ] Winapi: define the DPI policy and make `window.size`, mouse events, window position, popup placement, and screen metrics consistent under per-monitor DPI.
- [ ] Wayland: finish the public-coordinate policy so top-level window position uses the same scaled/backing coordinate model as `window.size`, mouse events, and popup placement.
- [ ] X11: define and implement a DPI-scaling policy for mouse events, window size, window position, popup placement, and screen metrics.
- [ ] Android: decide whether the backend should expose raw surface/view coordinates or a logical coordinate space, and document or implement that policy consistently.

## Wayland
- [ ] Use current xkb state for key mapping so `KeyEvent` respects active layout/group, not only unmodified symbols.
- [ ] Improve scroll handling by consuming `axis_source`, `axis_discrete`, and `axis_value120` events instead of relying on a fixed divisor.
- [ ] Revisit scroll normalization to avoid hardcoded `kde_default_mousewheel_scroll_length = 15`.
- [ ] Add Wayland text-input protocol support (`zwp_text_input_v3`) for robust IME behavior.
- [ ] Expose IME preedit/composition updates (composition string, cursor/candidate position) to app callbacks.

## X11
- [ ] Improve wheel handling beyond fixed button 4/5/6/7 `-1/+1` deltas.
- [ ] Investigate support for user scroll preferences (direction/speed) where available.
- [ ] Improve XIM text-input path to handle multi-stage IME composition updates more explicitly.

## Cocoa (macOS)
- [ ] Implement custom image cursor support on Cocoa.
- [ ] Add macOS branches in top-level window/screen wrappers where missing (for example `screenCount`/`screen`/`defaultScreen` in `src/siwin/window.nim`).

## IME / Text Input
- [ ] Add a cross-platform API for enabling/disabling text input mode (similar to `runeInputEnabled` semantics).
- [ ] Define consistent text input callbacks for commit text vs preedit text across backends.

#line 1
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

void main(void) {
    RectangleClip rect = fetch_rectangle_clip(gl_InstanceID);

#ifdef WR_FEATURE_TRANSFORM
    TransformVertexInfo vi = write_transform_vertex(rect.info);
    vPos = vi.local_pos;
    vLocalRect = vi.clipped_local_rect;
#else
    VertexInfo vi = write_vertex(rect.info);
    vPos = vi.local_clamped_pos;
#endif

    vClipRect = vec4(rect.clip.rect.xy, rect.clip.rect.xy + rect.clip.rect.zw);
    vClipRadius = vec4(rect.clip.top_left.outer_inner_radius.x,
                       rect.clip.top_right.outer_inner_radius.x,
                       rect.clip.bottom_right.outer_inner_radius.x,
                       rect.clip.bottom_left.outer_inner_radius.x);

    vColor = rect.color;
}

stop_sound(fall_sound);
fall_sound = undefined;
if (surface_exists(silhouette_surface)) { surface_free(silhouette_surface); }
if (surface_exists(solid_mask_surface)) { surface_free(solid_mask_surface); }
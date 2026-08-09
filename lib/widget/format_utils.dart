String formatVolume(int volume) {
  if (volume >= 1000000000) return '${(volume / 1000000000).toStringAsFixed(1)}B';
  if (volume >= 1000000) return '${(volume / 1000000).toStringAsFixed(1)}M';
  if (volume >= 1000) return '${(volume / 1000).toStringAsFixed(1)}K';
  return volume.toString();
}

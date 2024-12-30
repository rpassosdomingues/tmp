#!/bin/bash

# Nome do arquivo de entrada
input_video="video.mkv"

# Verifica se o arquivo de entrada existe
if [ ! -f "$input_video" ]; then
  echo "Erro: O arquivo '$input_video' não foi encontrado."
  exit 1
fi

# Nome do arquivo de saída
output_video="output_video_no_silence.mkv"

# Aplica o filtro silenceremove para remover os silêncios automaticamente
echo "Removendo silêncios de '$input_video'..."
ffmpeg -i "$input_video" -af silenceremove=start_periods=1:start_threshold=-50dB:start_duration=1 -c:v copy -c:a aac -b:a 192k "$output_video"

# Verifica se o comando foi executado com sucesso
if [ $? -eq 0 ]; then
  echo "Vídeo sem silêncios gerado com sucesso: '$output_video'"
else
  echo "Erro ao processar o vídeo."
  exit 1
fi


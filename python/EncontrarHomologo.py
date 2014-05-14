__author__ = 'Frederico'
import collections

from numpy import random
import numpy as np
import cv2


img = cv2.imread('maraca_1.tif')
img2 = cv2.imread('maraca_2.tif')
# img = cv2.imread('1997_017_300dpi.bmp')
# img2 = cv2.imread('1997_018_300dpi.bmp')
# imgHSV = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

#Fazer IHS e usar a banda S ou fazer nas 3 bandas (raiz da soma dos quadrados das cores)

#TESTE FEITO: CLICK EM
#
# Ordenando
# 95.0142166503 (329, 491)
# 239.729266789 (895, 55)
# 248.876282463 (889, 65)
# FIM

print img.shape
print img2.shape

# mouse callback function
def draw_circle(event, x, y, flags, param):
    if event == cv2.EVENT_LBUTTONUP:
        #Fixei os valores de X e Y, para utilizar o ponto clicado, apague as 2 linhas abaixo
        x = 993
        y = 745
        print 'Click ', x, y
        #Observer a troca na posicao X e Y
        encontrar_homologo((y, x), img, img2)
        cv2.circle(img, (x, y), 5, (255, 0, 0), -1)
        print 'FIM'


def init():
    screen_res = 1024.0, 768.0
    scale_width = screen_res[0] / img.shape[1]
    scale_height = screen_res[1] / img.shape[0]
    scale = min(scale_width, scale_height)
    window_width = int(img.shape[1] * scale)
    window_height = int(img.shape[0] * scale)

    cv2.namedWindow('image', cv2.WINDOW_NORMAL)
    cv2.resizeWindow('image', window_width, window_height)

    #Callback para o click do mouse
    cv2.setMouseCallback('image', draw_circle)

    cv2.namedWindow('image2', cv2.WINDOW_NORMAL)
    cv2.resizeWindow('image2', window_width, window_height)


def encontrar_homologo(coords, img_, img2_):
    candidato = {}
    x = coords[0]
    y = coords[1]

    #Recorta a matriz da imagem 1 em 5x5
    quadrante = img_[x - 2:x + 3, y - 2:y + 3].astype(np.int32)

    #Percorrer os pixels da matriz da imagem 2, comecando no 5x5 e terminando em Xmax -5 e Ymax -5. Fiz isso pq as matrizes recortadas precisam ser no min 5x5.
    for x in range(5, img2_.shape[0] - 5, 2):
        for y in range(5, img2_.shape[1] - 5, 2):
            quadrante_candidato = img2_[x - 2:x + 3, y - 2:y + 3].astype(np.int32)

            #Calculo da soma das diferencas!!!!!!!!!!
            quadrante_dif = quadrante - quadrante_candidato
            norma_quadrante_dif = np.sqrt(quadrante_dif[:, :, 0] ** 2 + quadrante_dif[:, :, 1] ** 2 + quadrante_dif[:, :, 2] ** 2)
            somatorio_norma_quadrante_dif = norma_quadrante_dif.sum()

            #Depois adiciono em uma lista e ordeno

            a = float(somatorio_norma_quadrante_dif)
            if a > 400:
                continue
            if candidato.has_key(a):
                b = random.random()
                a = a + b
            candidato[a] = (y, x)

    print 'Ordenando'
    od = collections.OrderedDict(sorted(candidato.items()))

    #Pintar os TOP 3 no mapa da imagem 2
    i = 0
    for k, v in od.iteritems():
        if i > 2:
            break
        i += 1
        cv2.circle(img2, v, 5, (0, 255, 0), -1)
        print k, v

init()

while (1):
    cv2.imshow('image', img)
    cv2.imshow('image2', img2)
    k = cv2.waitKey(1) & 0xFF
    if k == ord('m'):
        mode = not mode
    elif k == 27:
        break

cv2.destroyAllWindows()


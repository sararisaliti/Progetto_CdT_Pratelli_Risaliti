$(document).ready(function () {
  // Inizializza il resize dinamico delle aree mappa quando la pagina viene caricata, adattando le dimensioni delle aree cliccabili all'interno di una mappa immagine.
    $('map').imageMapResize();

    // Gestisce il click sulle aree della mappa, previene il comportamento predefinito del link, esegue uno scroll animato verso l'elemento corrispondente e applica un'animazione di evidenziazione sul target selezionato.
    $("area").click(function (e) {
        e.preventDefault();

        let id_area = $(this).attr("id");
        if (!id_area) return;

        console.log("Hai cliccato:", id_area);

        let target = $("#" + id_area);
        if (target.length > 0) {
            $("html, body").animate({
                scrollTop: target.offset().top - 100
            }, 1000);

            target.addClass("active-background");

            setTimeout(function () {
                target.removeClass("active-background");
            }, 3000);
        } else {
            console.warn("Elemento non trovato:", id_area);
        }
    });
});

// Gestisce il toggle della visibilità delle immagini corrispondenti al bottone per aprire la Rassegna.
$(document).ready(function () {
  $('.btn-toggle-immagini').on('click', function () {
    const $container = $(this).next('.immagini-corrispondenza');

    $container.slideToggle(400, () => {
      if ($container.is(':visible')) {
        $container.find('img[usemap]').each(function () {
          const mapName = $(this).attr('usemap').replace('#', '');
          const $map = $('map[name="' + mapName + '"]');
          if ($map.length > 0) {
            imageMapResize.call($map.get(0));
          }
        });
      }
    });

    $(this).toggleClass('attivo');
  });
});


// Gestisce il click sui bottoni dei fenomeni notevoli.
document.addEventListener("DOMContentLoaded", function () {
  const bottoni = document.querySelectorAll("#bottoni button");

  bottoni.forEach(bottone => {
    bottone.addEventListener("click", () => {
      const classe = bottone.id;

      bottone.classList.toggle("attivo");

      if (classe === "regolarizzazioni") {
        document.querySelectorAll(".regolarizzazioni-group").forEach(gruppo => {
          gruppo.classList.toggle("regolarizzazioni-attiva");
        });
      } else if (classe === "correzioni") {
        document.querySelectorAll(".correzioni-group").forEach(gruppo => {
          gruppo.classList.toggle("correzioni-attiva");
        });
      } else {
        document.querySelectorAll(`.${classe}`).forEach(elem => {
          elem.classList.toggle(`evidenzia-${classe}`);
        });
      }
    });
  });
});

// Gestisce il click sugli elementi a popup della nav.
document.addEventListener('DOMContentLoaded', function () {
  const buttons = document.querySelectorAll('.main_menu_item');
  const popups = document.querySelectorAll('.menu_content');

  buttons.forEach(button => {
    button.addEventListener('click', () => {
      const id = button.getAttribute('data-id');

      popups.forEach(p => {
        if (p.id === id) {
          p.classList.toggle('menu_content_hide');
        } else {
          p.classList.add('menu_content_hide');
        }
      });
    });
  });
});


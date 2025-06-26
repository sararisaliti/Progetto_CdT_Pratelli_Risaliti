<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Chiavi per id/ref: note e persone -->
  <xsl:key name="noteById" match="tei:note" use="@xml:id"/>
  <xsl:key name="persName-by-id" match="tei:persName" use="@xml:id"/>

  <!-- Root -->
  <xsl:template match="/tei:TEI">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="progettostile.css"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/image-map-resizer@1.0.10/js/imageMapResizer.min.js"></script>
        <script type="text/javascript" src="progetto.js"></script>
        <title>La Rassegna Settimanale - Progetto Codifica di Testi</title>
      </head>

      <body>
        <xsl:call-template name="navbar"/>

        <!-- Immagine centrale logo -->
        <div class="logo-decorativo my-4 text-center">
          <img src="logo_rassegna.jpg" alt="Logo La Rassegna" style="max-width: 900px; margin-top:80px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);"/>
        </div>

        <!-- Contenitore fenomeni notevoli -->
        <div id="fenomeni-container">
          <h2 class="fenomeni-titolo">Fenomeni Notevoli</h2>
          <p class="fenomeni-sottotitolo">Clicca sui bottoni ed evidenzia gli elementi di codifica che più ti interessano</p>
        </div>
        <!-- Bottoni -->
        <div id="bottoni-container">
          <div id="bottoni">
            <button id="persone">Persone</button>
            <button id="personaggi">Personaggi</button>
            <button id="Luoghi_countries">Paesi e Regioni</button>
            <button id="Luoghi_settlements">Città</button>
            <button id="Luoghi_n">Luoghi naturali e Aree</button>
            <button id="ref_bibl">Opere</button>
            <button id="CasaEd">Casa editrice</button>
            <button id="Date">Date</button>
            <button id="testo_lingua">Testo in lingua straniera</button>
            <button id="quotes">Citazioni</button>
            <button id="org">Organizzazioni</button>
            <button id="epithet_rolenames">Epiteti, Apposizioni e Ruoli</button>
            <button id="termini_filosofici">Termini filosofici</button>
            <button id="termini_legali">Termini legali e economici</button>
            <button id="espressioni_metaforiche">Espressioni metaforiche</button>
            <button id="termini_sociali">Termini sociali e Temi</button>
            <button id="verbum">Verbum</button>
            <button id="correzioni">Errori e correzioni</button>
            <button id="regolarizzazioni">Originali e Regolarizzate</button>
          </div>
        </div>

        <!-- Sezione articoli -->
        <div id="all_articles">
          <xsl:apply-templates select="//tei:text[@xml:id='IL_TRATTATO_DI_COMMERCIO']"/>
          <xsl:apply-templates select="//tei:text[@xml:id='CORRISPONDENZA_DA_PRATO']"/>
          <xsl:apply-templates select="//tei:text[@xml:id='ORIGINI_SCHOPENHAUER']"/>
        </div>

        <!-- Sezione bibliografia -->
        <div id="all_bibliografia" class="all">
          <xsl:apply-templates select="//tei:text[@xml:id='Bibliografia']/tei:front/tei:div[@type='main']/tei:head"/>
          <xsl:apply-templates select="//tei:text[@xml:id='bibl_carducci']"/>
          <xsl:apply-templates select="//tei:text[@xml:id='bibl_zonghi']"/>
        </div>

        <!-- Sezione Notizie -->
        <div id="all_notizie" class="all">
          <xsl:apply-templates select="//tei:text[@xml:id='notizie']/tei:front/tei:div[@type='main']/tei:head"/>
          <xsl:apply-templates select="//tei:text[@xml:id='notizie']"/>
        </div>

      </body>
    </html>
  </xsl:template>

  <!-- Navbar -->
  <xsl:template name="navbar">
    <div class="main_menu">
      <div class="main_menu_item" data-id="popup-rassegna">LA RASSEGNA</div>
      <a class="logo-home" href="La_Rassegna.html">
        <img src="logoRS.JPG" alt="Logo" width="50" />
      </a>
      <div class="main_menu_item" data-id="popup-progetto">IL PROGETTO</div>
    </div>

    <!-- Contenuto popup LA RASSEGNA -->
    <div id="popup-rassegna" class="menu_content menu_content_hide">
      <div id="logo" class="text-center mb-4">
        <img src="logo_rassegna.jpg" alt="La_Rassegna_Settimanale" style="max-width: 600px; display: block; margin: 0 auto;"/>
      </div>
      <div id="tit1" class="text-center">
        <h2>
          <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main']"/>
        </h2>
        <h3>
          <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='sub'][1]"/>
        </h3>

        <p class="mt-3">
          <b>Fondata da: </b>
          <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:funder"/>
        </p>

        <p>
          <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:editionStmt"/>
        </p>
      </div>
    </div>

    <!-- Contenuto popup IL PROGETTO -->
    <div id="popup-progetto" class="menu_content menu_content_hide">
      <div id="logo" class="text-center mb-4">
        <img src="logounipi.png" alt="Logo" style="max-width: 400px; display: block; margin: 0 auto;"/>
      </div>

      <div id="descrizioni" class="text-left">
        <h2 class="text-center mb-4">Descrizione del progetto:</h2>

        <div id="profile_desc" class="mb-4">
          <p>
            <xsl:value-of select="tei:teiHeader/tei:profileDesc/tei:abstract"/>
          </p>
        </div>

        <div id="encoding_desc" class="mb-4">
          <xsl:apply-templates select="tei:teiHeader/tei:encodingDesc/tei:projectDesc"/>
          <xsl:apply-templates select="tei:teiHeader/tei:encodingDesc/tei:editorialDecl"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- Template <gi> bold -->
  <xsl:template match="//tei:gi">
    <b><xsl:value-of select="."/></b>
  </xsl:template>

  <!-- Mostrare il contenuto della nota in un popup quando il mouse ci passa sopra -->
  <xsl:template match="tei:ref[@ana]">
    <xsl:variable name="noteId" select="substring-after(@ana, '#')"/>
    <xsl:variable name="note" select="//tei:note[@xml:id=$noteId]"/>
    <span class="note-hover" onmouseover="showNote(this)" onmouseout="hideNote(this)">
      <xsl:value-of select="$note/@n"/>
      <span class="popup-note">
        <xsl:apply-templates select="$note"/>
      </span>
    </span>
  </xsl:template>

  <!-- TEMPLATE: Articolo "Il trattato di commercio", stessa gestione per i 3 articoli-->
  <xsl:template match="tei:text[@xml:id='IL_TRATTATO_DI_COMMERCIO']">
    <!-- Contenitore principale dell’articolo -->
    <div class="articolo">
      <!-- Definiamo un prefisso comune per identificare le sezioni di testo divise in pagine e colonne -->
      <xsl:variable name="prefix" select="'trattato_pg'"/>
      <!-- Selezioniamo tutti i <div> con xml:id che iniziano con il prefisso definito -->
      <xsl:variable name="colonne" select=".//tei:div[starts-with(@xml:id, $prefix)]"/>

      <!-- Sezione per titolo e sottotitolo, estratti da <front> -->
      <div class="titolo-articolo">
        <!-- Titolo principale -->
        <xsl:for-each select="tei:front/tei:div[@type='main']/tei:head">
          <h2 id="tit_primobrano" class="zone" style="text-align: center; text-transform: uppercase;">
            <xsl:apply-templates/>
          </h2>
        </xsl:for-each>

        <!-- Sottotitolo -->
        <xsl:for-each select="tei:front/tei:div[@type='subtitle']/tei:head">
          <h3 id="subtit_primobrano" class="zone" style="text-align: center; text-transform: uppercase;">
            <xsl:apply-templates/>
          </h3>
        </xsl:for-each>
      </div>

      <!-- Ciclo che raggruppa le sezioni testuali per pagina, basandosi sulla parte numerica dopo il prefisso e prima del suffisso di colonna -->
      <xsl:for-each-group select="$colonne" group-by="substring-before(substring-after(@xml:id, $prefix), '_col')">
        <div class="pagina d-flex flex-row justify-content-between mb-4">
          
          <!-- Colonna sinistra (colSX) -->
          <div class="colonna-sx w-50 pe-2 border-end">
            <xsl:apply-templates select="current-group()[contains(@xml:id, '_colSX')]"/>
          </div>

          <!-- Colonna destra (colDX), con fallback se non presente -->
          <div class="colonna-dx w-50 ps-2">
            <xsl:choose>
              <xsl:when test="current-group()[contains(@xml:id, '_colDX')]">
                <xsl:apply-templates select="current-group()[contains(@xml:id, '_colDX')]"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- Se la colonna DX è assente, viene visualizzato uno spazio bianco per mantenere la struttura -->
                <div style="min-height: 300px;"></div>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>

        <!-- Linea orizzontale tra pagine, tranne dopo l’ultima -->
        <xsl:if test="position() != last()">
          <hr class="separatore-pagina"/>
        </xsl:if>
      </xsl:for-each-group>
          
      <!-- Bottone per mostrare le immagini della Rassegna con mappa interattiva -->
      <button class="btn-toggle-immagini">
        Guarda la corrispondenza sulla Rassegna e clicca un paragrafo
      </button>

      <!-- Sezione nascosta con le immagini facsimilari, visualizzabili al clic del bottone -->
      <div class="immagini-corrispondenza" style="display: none;">
        <div class="row gx-3 gy-3">

          <!-- Immagine 1 -->
          <div class="col-md-6">
            <div class="image" id="Il_tratt_comm_1.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina161']"/>
            </div>
          </div>

          <!-- Immagine 2 -->
          <div class="col-md-6">
            <div class="image" id="Il_tratt_comm_2.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina162']"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- TEMPLATE: Articolo "Corrispondenza da Prato", stessa gestione per i 3 articoli-->
  <xsl:template match="tei:text[@xml:id='CORRISPONDENZA_DA_PRATO']">
    <div class="articolo">

      <div class="titolo-articolo">
        <xsl:for-each select="tei:front/tei:div[@type='main']/tei:head">
          <h2 id="tit_secondobrano" class="zone" style="text-align: center; text-transform: uppercase;">
            <xsl:apply-templates/>
          </h2>
        </xsl:for-each>

        <xsl:for-each select="tei:front/tei:div[@type='subtitle']/tei:head">
          <h3 id="subtit_secondobrano" class="zone" style="text-align: center; text-transform: uppercase;">
            <xsl:apply-templates/>
          </h3>
        </xsl:for-each>
      </div>

      <xsl:variable name="prefix" select="'corrispondenza_pg'"/>
      <xsl:variable name="colonne" select=".//tei:div[starts-with(@xml:id, $prefix)]"/>

      <xsl:for-each-group select="$colonne" group-by="substring-before(substring-after(@xml:id, $prefix), '_col')">
        <div class="pagina d-flex flex-row justify-content-between mb-4">

          <div class="colonna-sx w-50 pe-2 border-end">
            <xsl:apply-templates select="current-group()[contains(@xml:id, '_colSX')]"/>
          </div>

          <div class="colonna-dx w-50 ps-2">
            <xsl:choose>
              <xsl:when test="current-group()[contains(@xml:id, '_colDX')]">
                <xsl:apply-templates select="current-group()[contains(@xml:id, '_colDX')]"/>
              </xsl:when>
              <xsl:otherwise>
                <div style="min-height: 300px;"></div>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>
        <xsl:if test="position() != last()">
          <hr class="separatore-pagina"/>
        </xsl:if>
      </xsl:for-each-group>

      <button class="btn-toggle-immagini">
        Guarda la corrispondenza sulla Rassegna e clicca un paragrafo
      </button>

      <div class="immagini-corrispondenza" style="display: none;">
        <div class="row gx-3 gy-3">
          <div class="col-md-6">
            <div class="image" id="corr_prato_1.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina167']"/>
            </div>
          </div>
          <div class="col-md-6">
            <div class="image" id="corr_prato_2.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina168']"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- TEMPLATE: Articolo "Le origini della filosofia", stessa gestione per i 3 articoli-->
  <xsl:template match="tei:text[@xml:id='ORIGINI_SCHOPENHAUER']">
    <div class="articolo">

      <div class="titolo-articolo">
        <xsl:for-each select="tei:front/tei:div[@type='main']/tei:head">
          <h2 id="tit_terzobrano" class="zone" style="text-align: center; text-transform: uppercase;">
            <xsl:apply-templates/>
          </h2>
        </xsl:for-each>

        <xsl:for-each select="tei:front/tei:div[@type='subtitle']/tei:head">
          <h3 id="subtit_terzobrano" class="zone" style="text-align: center; text-transform: uppercase;">
            <xsl:apply-templates/>
          </h3>
        </xsl:for-each>
      </div>

      <xsl:variable name="prefix" select="'schopenhauer_pg'"/>
      <xsl:variable name="colonne" select=".//tei:div[starts-with(@xml:id, $prefix)]"/>

      <xsl:for-each-group select="$colonne" group-by="substring-before(substring-after(@xml:id, $prefix), '_col')">
        <div class="pagina d-flex flex-row justify-content-between mb-4">

          <div class="colonna-sx w-50 pe-2 border-end">
            <xsl:apply-templates select="current-group()[contains(@xml:id, '_colSX')]"/>
          </div>

          <div class="colonna-dx w-50 ps-2">
            <xsl:choose>
              <xsl:when test="current-group()[contains(@xml:id, '_colDX')]">
                <xsl:apply-templates select="current-group()[contains(@xml:id, '_colDX')]"/>
              </xsl:when>
              <xsl:otherwise>
                <div style="min-height: 300px;"></div> 
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>

        <xsl:if test="position() != last()">
          <hr class="separatore-pagina"/>
        </xsl:if>
      </xsl:for-each-group>

      <button class="btn-toggle-immagini">
        Guarda la corrispondenza sulla Rassegna e clicca un paragrafo
      </button>

      <div class="immagini-corrispondenza" style="display: none;">
        <div class="row gx-3 gy-3">
          <div class="col-md-6">
            <div class="image" id="orig_filo_1.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina173']"/>
            </div>
          </div>
          <div class="col-md-6">
            <div class="image" id="orig_filo_2.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina174']"/>
            </div>
          </div>
        </div>
        <div class="row gx-3 gy-3 mt-3">
          <div class="col-md-6">
            <div class="image" id="orig_filo_3.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina175']"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- TEMPLATE: Bibliografia "Carducci", stessa gestione per le 2 entrate della bibliografia -->
  <xsl:template match="tei:text[@xml:id='bibl_carducci']">
    <div class="articolo mx-auto p-4 m-4 bg-white rounded shadow-sm" style="max-width: 1000px;">
      
      <!-- Titolo principale dell'articolo bibliografico -->
      <div class="titolo-articolo text-center mb-3">
        <xsl:apply-templates select="tei:front/tei:div[@type='main']/tei:head"/>
      </div>

      <!-- Divisione in colonne per pagina -->
      <xsl:variable name="colonne" select=".//tei:div[starts-with(@xml:id, 'carducci_pg')]"/>
      <xsl:for-each-group select="$colonne" group-by="substring-before(substring-after(@xml:id, 'carducci_pg'), '_col')">
        <div class="pagina d-flex flex-row justify-content-between mb-4">

          <!-- Colonna sinistra -->
          <div class="colonna-sx w-50 pe-2 border-end">
            <xsl:apply-templates select="current-group()[contains(@xml:id, '_colSX')]"/>
          </div>

          <!-- Colonna destra (con fallback in caso di assenza) -->
          <div class="colonna-dx w-50 ps-2">
            <xsl:choose>
              <xsl:when test="current-group()[contains(@xml:id, '_colDX')]">
                <xsl:apply-templates select="current-group()[contains(@xml:id, '_colDX')]"/>
              </xsl:when>
              <xsl:otherwise>
                <div style="min-height: 300px;"></div>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>

        <!-- Separatore tra pagine -->
        <xsl:if test="position() != last()">
          <hr class="separatore-pagina"/>
        </xsl:if>
      </xsl:for-each-group>

      <!-- Bottone e immagine della facciata della Rassegna -->
      <button class="btn-toggle-immagini">
        Guarda la corrispondenza sulla Rassegna e clicca un paragrafo
      </button>
      <div class="immagini-corrispondenza" style="display: none;">
        <div class="row gx-3 gy-3">
          <div class="col-md-6">
            <div class="image" id="bibl_carducci.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina176']"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- TEMPLATE: Bibliografia "Zonghi", stessa gestione per le 2 entrate della bibliografia -->
  <xsl:template match="tei:text[@xml:id='bibl_zonghi']">
    <div class="articolo mx-auto p-4 m-4 bg-white rounded shadow-sm" style="max-width: 1000px;">

      <div class="titolo-articolo text-center mb-3">
        <xsl:apply-templates select="tei:front/tei:div[@type='main']/tei:head"/>
      </div>

      <xsl:variable name="colonne" select=".//tei:div[starts-with(@xml:id, 'zonghi_pg')]"/>
      <xsl:for-each-group select="$colonne" group-by="substring-before(substring-after(@xml:id, 'zonghi_pg'), '_col')">
        <div class="pagina d-flex flex-row justify-content-between mb-4">

          <div class="colonna-sx w-50 pe-2 border-end">
            <xsl:apply-templates select="current-group()[contains(@xml:id, '_colSX')]"/>
          </div>

          <div class="colonna-dx w-50 ps-2">
            <xsl:choose>
              <xsl:when test="current-group()[contains(@xml:id, '_colDX')]">
                <xsl:apply-templates select="current-group()[contains(@xml:id, '_colDX')]"/>
              </xsl:when>
              <xsl:otherwise>
                <div style="min-height: 300px;"></div>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>

        <xsl:if test="position() != last()">
          <hr class="separatore-pagina"/>
        </xsl:if>
      </xsl:for-each-group>

      <button class="btn-toggle-immagini">
        Guarda la corrispondenza sulla Rassegna e clicca un paragrafo
      </button>
      <div class="immagini-corrispondenza" style="display: none;">
        <div class="row gx-3 gy-3">
          <div class="col-md-6">
            <div class="image" id="bibl_zonghi.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina177']"/>
            </div>
          </div>
          <div class="col-md-6">
            <div class="image" id="bibl_zonghi_2.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina178']"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- TEMPLATE: Entrate notizie -->
  <xsl:template match="tei:text[@xml:id='notizie']">
    <div class="articolo">
      <!-- Sezione unica con le due entrate a destra -->
      <div class="pagina d-flex flex-row justify-content-between mb-4">
        <!-- Colonna sinistra vuota ma presente per simmetria -->
        <div class="colonna-sx w-50 pe-2 border-end">
          <!-- Vuoto -->
        </div>

        <!-- Colonna destra con le due entrate -->
        <div class="colonna-dx w-50 ps-2">
          <xsl:apply-templates select="tei:body/tei:div[@xml:id='primauscita_not']"/>
          <xsl:apply-templates select="tei:body/tei:div[@xml:id='secondauscita_not']"/>
        </div>
      </div>

      <!-- Bottone per il facsimile -->
      <button class="btn-toggle-immagini">
        Guarda la corrispondenza sulla Rassegna e clicca un paragrafo
      </button>

      <!-- Immagine facsimilare -->
      <div class="immagini-corrispondenza" style="display: none;">
        <div class="row gx-3 gy-3">
          <div class="col-md-6">
            <div class="image" id="notizia_1.jpg">
              <xsl:apply-templates select="//tei:surface[@xml:id='pagina179']"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- Titolo di sezioni come Bibliografia e Notizie -->
  <xsl:template match="tei:head">
    <h2 class="titolo-sezione">
      <!-- Applica i template ai contenuti interni di <head>, così da visualizzare correttamente eventuali parti formattate -->
      <xsl:apply-templates/>
    </h2>
  </xsl:template>

  <!-- Template per gestire l’elemento <editionStmt> del teiHeader.
     Questo blocco produce la visualizzazione dell’edizione e dei responsabili,
     con formattazione corretta di date e nomi. -->
  <xsl:template match="tei:editionStmt"> 

    <!-- Estraiamo il contenuto testuale dell’elemento <edition>,
    che può includere anche una <date> annidata. -->
    <xsl:value-of select="tei:edition"/>

    <!-- Aggiungiamo uno spazio per separare l’edizione dal resto -->
    <xsl:text> </xsl:text>

    <!-- Estraiamo e mostra il contenuto testuale della data (se presente come elemento interno) -->
    <xsl:value-of select="tei:date"/>
    <!-- Andiamo a capo prima di iniziare i blocchi dei responsabili -->
    <br />

    <!-- Ciclo su ogni <respStmt>, che rappresenta un gruppo di responsabilità -->
    <xsl:for-each select="tei:respStmt">
      <!-- Visualiziamo la descrizione del ruolo (es. “Responsabili di codifica:”) -->
      <xsl:value-of select="tei:resp"/>
      <xsl:text> </xsl:text>

      <!-- Contiamo il numero totale di <name> per gestire correttamente virgole e "e" -->
      <xsl:variable name="n" select="count(tei:name)"/>

      <!-- Ciclo su tutti i <name> dentro al gruppo di responsabilità -->
      <xsl:for-each select="tei:name">
        <!-- Stampiamo il nome -->
        <xsl:value-of select="."/>
        <!-- Gestiamo la punteggiatura in base alla posizione -->
        <xsl:choose>
          <!-- Se siamo al penultimo nome, inserisce " e " -->
          <xsl:when test="position() = $n - 1"> e </xsl:when>
          <!-- Se siamo prima del penultimo, inserisce una virgola -->
          <xsl:when test="position() &lt; $n - 1">, </xsl:when>
          <!-- Se siamo all’ultimo, chiude con un punto -->
          <xsl:when test="position() = $n">.</xsl:when>
        </xsl:choose>
      </xsl:for-each>
      <br/>
    </xsl:for-each>
  </xsl:template>

  <!-- TEMPLATE: projectDesc
       Questo template gestisce l’elemento <projectDesc>, che descrive il progetto editoriale
       all'interno del blocco <encodingDesc> del teiHeader.
        
       Per ogni paragrafo <p> contenuto in <projectDesc>, crea un elemento HTML <p>,
       mantenendo il contenuto interno e applicando eventuali ulteriori template
       (es. se ci sono elementi inline marcati come <hi>, <ref>, ecc.). 
  -->
  <xsl:template match="tei:encodingDesc/tei:projectDesc">
    <xsl:for-each select="tei:p">
      <p><xsl:apply-templates/></p>
    </xsl:for-each>
  </xsl:template>

  <!-- TEMPLATE: editorialDecl
      Questo template elabora l’elemento <editorialDecl>, parte della sezione <encodingDesc> del teiHeader,
      che serve a documentare le scelte editoriali adottate nel processo di codifica (es. criteri per trascrizioni,
      normalizzazioni, correzioni, ecc.).

      Per ogni paragrafo <p> incluso in <editorialDecl>, crea un elemento HTML <p>,
      mantenendo la struttura e applicando eventuali altri template interni (ad es. per <hi>, <ref>, <choice>...).
  -->
  <xsl:template match="tei:encodingDesc/tei:editorialDecl">
    <xsl:for-each select=".//tei:p">
      <p><xsl:apply-templates/></p>
    </xsl:for-each>
  </xsl:template>

  <!-- TEMPLATE: lb (line break)
     Questo template trasforma ogni elemento <lb> (line break) della codifica TEI
     in un'interruzione di riga HTML (<br/>).

     In TEI, <lb> viene utilizzato per segnalare un cambio di riga nel testo originale (ad es. nella stampa).
     La trasformazione con <br/> mantiene visivamente la struttura a righe del documento di partenza
     nell'output HTML.
  -->
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <!-- TEMPLATE: surface
      Questo template gestisce l’elemento <surface> della codifica TEI, che rappresenta una pagina
      digitalizzata (ad esempio una facsimile della rivista) con aree cliccabili sovrapposte.

      - Il contenuto della surface viene trasformato in un <div> HTML con classe "pagina".
      - All'interno, viene inserita un'immagine (<img>) con classe "small" e attributo "usemap",
        che collega l'immagine a una mappa interattiva tramite l’attributo @xml:id.

      - L’attributo usemap="#id" permette di definire una mappa HTML <map> con aree cliccabili
        (<area>) definite in base ai sottoelementi <zone> di TEI.

      - Ogni <tei:zone> definisce un’area rettangolare (shape="rect") sulla pagina,
        con coordinate fornite da @ulx, @uly, @lrx, @lry.
        Queste aree sono collegate tramite href all'id del corrispondente elemento testuale.

      In questo modo si crea un collegamento bidirezionale tra immagine e testo:
      cliccando su una porzione dell’immagine, si salta al paragrafo testuale associato.
  -->
  <xsl:template match="tei:surface"> 
    <div class="pagina">
      <img class="small"
          src="{tei:graphic/@url}"
          usemap="#{@xml:id}"/>

      <map name="{@xml:id}">
        <xsl:for-each select="tei:zone">
          <area shape="rect"
                coords="{@ulx},{@uly},{@lrx},{@lry}"
                href="#{@corresp}"
                id="{@corresp}"
                style="cursor: pointer;"/>
        </xsl:for-each>
      </map>
    </div>
  </xsl:template>

  <!-- PERSONE -->
  <xsl:template match="tei:persName">
    <!-- Se l’attributo @ref è presente, creiamo un link -->
    <xsl:choose>
      <xsl:when test="@ref">
        <!-- Estraiamo l’ID dal riferimento -->
        <xsl:variable name="id" select="substring-after(@ref, '#')"/>
        <!-- Cerchiamo nella chiave persName-by-id il valore @ref -->
        <xsl:variable name="link" select="key('persName-by-id', $id)/@ref"/>
        <!-- link -->
        <span class="persone">
          <a href="{ $link }">
            <xsl:apply-templates/>
          </a>
        </span>
      </xsl:when>

      <!-- Altrimenti, solo una span senza link -->
      <xsl:otherwise>
        <span class="persone">
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- PERSONAGGI -->
  <xsl:template match="tei:rs[@type='fictional']">
    <span class="personaggi">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- EPITETI, APPELLATIVI E RUOLI -->
  <xsl:template match="tei:roleName">
    <span class="epithet_rolenames">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:rs[@type='epithet' or @type='appellative' or @type='role']">
    <span class="epithet_rolenames">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- LUOGHI -->
  <!-- Paesi, Regioni e Stati storici -->
  <xsl:template match="tei:placeName[@type='country' or @type='region' or @type='historicalCountry']">
    <span class="Luoghi_countries">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Città -->
  <xsl:template match="tei:placeName[@type='city']">
    <span class="Luoghi_settlements">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Luoghi naturali e aree -->
  <xsl:template match="tei:placeName[@type='natural' or @type='area']">
    <span class="Luoghi_n">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- OPERE E CITAZIONI BIBLIOGRAFICHE -->
  <xsl:template match="tei:title[@rend='italic']" priority="2">
    <i class="ref_bibl">
      <xsl:apply-templates/>
    </i>
  </xsl:template>

  <!-- CASA EDITRICE -->
  <xsl:template match="tei:orgName[@type='editorial']">
    <span class="CasaEd">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- DATE -->
  <xsl:template match="tei:date">
    <span class="Date">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- CITAZIONI E QUOTES -->
  <xsl:template match="tei:quote">
    <span class="quotes">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- TESTO IN LINGUA STRANIERA -->
  <xsl:template match="tei:foreign">
    <span class="testo_lingua">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- ORGANIZZAZIONI -->
  <xsl:template match="tei:orgName[not(@type='editorial')]">
    <span class="org">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- TERMINI FILOSOFICI -->
  <xsl:template match="tei:term[@type='philosophy']">
    <span class="termini_filosofici">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- TERMINI LEGALI ED ECONOMICI -->
  <xsl:template match="tei:term[@type='legal' or @type='economic']">
    <span class="termini_legali">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- TERMINI SOCIALI E TEMI -->
  <xsl:template match="tei:term[@type='social' or @type='theme']">
    <span class="termini_sociali">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- ESPRESSIONI METAFORICHE -->
  <xsl:template match="tei:term[@type='metaphorical']">
    <span class="espressioni_metaforiche">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- VERBUM -->
  <xsl:template match="tei:rs[@type='verbum']">
    <span class="verbum">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- ERRORI E CORREZIONI -->
  <xsl:template match="tei:sic">
    <span class="sic">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- DISTINTI (REGOLE STILISTICHE E MODERNIZZAZIONI) -->
  <xsl:template match="tei:distinct">
    <span class="regolarizzazioni">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!--testo corsivo - non in caso di testo in lingua straniera, perchè gestito separatemente-->
  <xsl:template match="tei:*[@rend='italic'][not(self::tei:foreign)]">
      <i>
          <xsl:apply-templates select="node()"/>
      </i>
  </xsl:template>

  <!-- Gestione delle correzioni: <sic> + <corr> -->
  <xsl:template match="tei:choice[tei:sic and tei:corr]">
    <span class="correzioni-group">
      <span class="correzioni-sic">
        <xsl:apply-templates select="tei:sic"/>
      </span>
      <span class="correzioni-corr">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="tei:corr"/>
      </span>
    </span>
  </xsl:template>

  <!-- Gestione delle regolarizzazioni: <orig> + <reg> oppure <abbr> + <expan> -->
  <xsl:template match="tei:choice[tei:orig and tei:reg] | tei:choice[tei:abbr and tei:expan]">
    <span class="regolarizzazioni-group">
      <span class="regolarizzazioni-orig">
        <xsl:apply-templates select="tei:orig | tei:abbr"/>
      </span>
      <span class="regolarizzazioni-expan">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="tei:reg | tei:expan"/>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="tei:orig[not(parent::tei:choice)] | tei:abbr[not(parent::tei:choice)] | tei:expan[not(parent::tei:choice)]">
    <span class="regolarizzazioni">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Elementi figli complessi dentro expan -->
  <xsl:template match="tei:expan//*">
    <span class="regolarizzazioni">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Elementi figli complessi dentro abbr -->
  <xsl:template match="tei:abbr//*">
    <span class="regolarizzazioni">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- TEMPLATE PER I PARAGRAFI CON ID 
  
    Questo template gestisce gli elementi <p> del testo TEI che possiedono un attributo xml:id. 
    È fondamentale per creare un collegamento tra il paragrafo e la mappa interattiva dell’immagine,
    poiché l’attributo xml:id sarà usato come anchor (id HTML) per permettere click e navigazione diretta.
  -->
  <xsl:template match="tei:p[@xml:id]">
    <p class="paragrafo" id="{@xml:id}">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- Paragrafi normali, senza id -->
  <xsl:template match="tei:p">
    <p class="paragrafo">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

</xsl:stylesheet>
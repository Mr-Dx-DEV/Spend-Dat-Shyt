--[[ =============================================================================

		Project: "Enhanced Native Driveby Animations (ENDA)" v2.1.5
		Copyright � 2020-2025 Delta District (DeltaDistrict.com)

]]-- =============================================================================

-- LOCALES: AF, AR, BE, BG, BS, CS, DA, DE, EL, EN, ES, ET, FI, FR, GA, HE, HI, HR, HU, HY, ID, IS, IT, JA, KO, KU, LT, LV, MI, MK, MS, NL, NO, PL, PT, RO, SI, SK, SL, SR, SV, TA, TH, TR, UK, VE, VI, ZH, ZU

function LoadConfiguredLocale(locale) 
		--		Aim/Aiming			Blocked  			Disabled  			Quick Swap  			Default  			Custom
	
	if locale=='af' then -- AF (Afrikaans)
		return {aiming='Mik', blocked='Geblokkeer', disabled='Gedeaktiveer', quickswap='Vinnige Ruil', default='Verstek', custom='Pasgemaak'}
	
	elseif locale=='ar' then -- AR (Arabic)
		return {aiming='تصويب', blocked='محظور', disabled='معطل', quickswap='تبديل سريع', default='افتراضي', custom='مخصص'}
	
	elseif locale=='be' then -- BE (Belarusian)
		return {aiming='Мэтаванне', blocked='Заблакавана', disabled='Адключана', quickswap='Хуткая змена', default='Па змаўчанні', custom='Карыстальніцкі'}
	
	elseif locale=='bg' then -- BG (Bulgarian)
		return {aiming='Прицелване', blocked='Блокирано', disabled='Деактивирано', quickswap='Бърза смяна', default='По подразбиране', custom='Персонализирано'}
	
	elseif locale=='bs' then -- BS (Bosnian)
		return {aiming='Nišanjenje', blocked='Blokirano', disabled='Onemogućeno', quickswap='Brza Zamjena', default='Zadano', custom='Prilagođeno'}
	
	elseif locale=='cs' then -- CS (Czech)
		return {aiming='Míření', blocked='Blokováno', disabled='Zakázáno', quickswap='Rychlá výměna', default='Výchozí', custom='Vlastní'}
	
	elseif locale=='da' then -- DA (Danish)
		return {aiming='Sigtning', blocked='Blokeret', disabled='Deaktiveret', quickswap='Hurtigt skift', default='Standard', custom='Brugerdefineret'}
	
	elseif locale=='de' then -- DE (German)
		return {aiming='Zielen', blocked='Blockiert', disabled='Deaktiviert', quickswap='Schnellwechsel', default='Standard', custom='Benutzerdefiniert'}
	
	elseif locale=='el' then -- EL (Greek)
		return {aiming='Στόχευση', blocked='Αποκλεισμένο', disabled='Απενεργοποιημένο', quickswap='Γρήγορη Αλλαγή', default='Προεπιλογή', custom='Προσαρμοσμένο'}
	
	elseif locale=='en' then -- EN (English)
		return {aiming='Aiming', blocked='Blocked', disabled='Disabled', quickswap='Quick Swap', default='Default', custom='Custom'}
	
	elseif locale=='es' then -- ES (Spanish)
		return {aiming='Apuntando', blocked='Bloqueado', disabled='Deshabilitado', quickswap='Cambio Rápido', default='Predeterminado', custom='Personalizado'}
	
	elseif locale=='et' then -- ET (Estonian)
		return {aiming='Sihtimine', blocked='Blokeeritud', disabled='Keelatud', quickswap='Kiire vahetus', default='Vaikimisi', custom='Kohandatud'}
	
	elseif locale=='fi' then -- FI (Finnish)
		return {aiming='Tähtäys', blocked='Estetty', disabled='Pois käytöstä', quickswap='Nopea vaihto', default='Oletus', custom='Mukautettu'}
	
	elseif locale=='fr' then -- FR (French)
		return {aiming='Viser', blocked='Bloqué', disabled='Désactivé', quickswap='Échange rapide', default='Par défaut', custom='Personnalisé'}
	
	elseif locale=='ga' then -- GA (Irish)
		return {aiming='Ag díriú', blocked='Coiscthe', disabled='Díchumasaithe', quickswap='Malartú Tapa', default='Réamhshocrú', custom='Saincheaptha'}
	
	elseif locale=='he' then -- HE (Hebrew)
		return {aiming='כוונת', blocked='חסום', disabled='מושבת', quickswap='החלפה מהירה', default='ברירת מחדל', custom='מותאם אישית'}
	
	elseif locale=='hi' then -- HI (Hindi)
		return {aiming='निशाना लगाना', blocked='अवरुद्ध', disabled='अक्षम', quickswap='त्वरित बदलाव', default='डिफ़ॉल्ट', custom='कस्टम'}
	
	elseif locale=='hr' then -- HR (Croatian)
		return {aiming='Nišanjenje', blocked='Blokirano', disabled='Onemogućeno', quickswap='Brza Zamjena', default='Zadano', custom='Prilagođeno'}
	
	elseif locale=='hu' then -- HU (Hungarian)
		return {aiming='Célzás', blocked='Blokkolva', disabled='Letiltva', quickswap='Gyorsváltás', default='Alapértelmezett', custom='Egyedi'}
	
	elseif locale=='hy' then -- HY (Armenian)
		return {aiming='Նպատակադրում', blocked='Արգելափակված', disabled='Անջատված', quickswap='Արագ փոխարկում', default='Լռելյայն', custom='Հարմարեցված'}
	
	elseif locale=='id' then -- ID (Indonesian)
		return {aiming='Membidik', blocked='Diblokir', disabled='Dinonaktifkan', quickswap='Tukar Cepat', default='Bawaan', custom='Kustom'}
	
	elseif locale=='is' then -- IS (Islandic)
		return {aiming='Beina', blocked='Lokað', disabled='Óvirkt', quickswap='Hraðskipti', default='Sjálfgefið', custom='Sérsniðið'}
	
	elseif locale=='it' then -- IT (Italian)
		return {aiming='Mira', blocked='Bloccato', disabled='Disabilitato', quickswap='Cambio rapido', default='Predefinito', custom='Personalizzato'}
	
	elseif locale=='ja' then -- JA (Japanese)
		return {aiming='照準', blocked='ブロック済み', disabled='無効', quickswap='クイックスワップ', default='デフォルト', custom='カスタム'}
	
	elseif locale=='ko' then -- KO (Korean)
		return {aiming='조준', blocked='차단됨', disabled='비활성화됨', quickswap='빠른 교체', default='기본', custom='사용자 지정'}
		
	elseif locale=='ku' then -- KU (Kurdish)
		return {aiming='Nîşan', blocked='Astengkirî', disabled='Neçalakrawa', quickswap='Guherandina Lez', default='Standard', custom='Xwesandî'}
	
	elseif locale=='lt' then -- LT (Lithuanian)
		return {aiming='Taikymas', blocked='Užblokuota', disabled='Išjungta', quickswap='Greitas keitimas', default='Numatytasis', custom='Pritaikytas'}
	
	elseif locale=='lv' then -- LV (Latvian)
		return {aiming='Mērķēšana', blocked='Bloķēts', disabled='Atspējots', quickswap='Ātrā maiņa', default='Noklusējums', custom='Pielāgots'}
	
	elseif locale=='mi' then -- MI (Maori)
		return {aiming='Tātari', blocked='Kua aukatia', disabled='Kua monokia', quickswap='Huri Tere', default='Taunoa', custom='Ritenga'}
	
	elseif locale=='mk' then -- MK (Macedonian)
		return {aiming='Нишанење', blocked='Блокирано', disabled='Оневозможено', quickswap='Брза замена', default='Стандардно', custom='Прилагодено'}
	
	elseif locale=='ms' then -- MS (Malay)
		return {aiming='Membidik', blocked='Disekat', disabled='Dilumpuhkan', quickswap='Tukar Pantas', default='Lalai', custom='Tersuai'}
	
	elseif locale=='nl' then -- NL (Dutch)
		return {aiming='Richten', blocked='Geblokkeerd', disabled='Uitgeschakeld', quickswap='Snelle Wissel', default='Standaard', custom='Aangepast'}
	
	elseif locale=='no' then -- NO (Norwegian)
		return {aiming='Sikting', blocked='Blokkert', disabled='Deaktivert', quickswap='Hurtigbytte', default='Standard', custom='Egendefinert'}
	
	elseif locale=='pl' then -- PL (Polish)
		return {aiming='Celowanie', blocked='Zablokowany', disabled='Wyłączony', quickswap='Szybka zmiana', default='Domyślny', custom='Niestandardowy'}
	
	elseif locale=='pt' then -- PT (Portuguese)
		return {aiming='Mira', blocked='Bloqueado', disabled='Desativado', quickswap='Troca Rápida', default='Padrão', custom='Personalizado'}
	
	elseif locale=='ro' then -- RO (Romanian)
		return {aiming='Țintire', blocked='Blocat', disabled='Dezactivat', quickswap='Schimb rapid', default='Implicit', custom='Personalizat'}
	
	elseif locale=='si' then -- SI (Sinhalese)
		return {aiming='ඇඳීම', blocked='අවහිර', disabled='අක්‍රිය', quickswap='ඉක්මන් මාරු', default='පෙරනිමි', custom='අභිරුචි'}
	
	elseif locale=='sk' then -- SK (Solvak)
		return {aiming='Mierenie', blocked='Blokované', disabled='Zakázané', quickswap='Rýchla výmena', default='Predvolené', custom='Vlastné'}
	
	elseif locale=='sl' then -- SL (Slovene)
		return {aiming='Merjenje', blocked='Blokirano', disabled='Onemogočeno', quickswap='Hitro preklapljanje', default='Privzeto', custom='Prilagojeno'}
	
	elseif locale=='sr' then -- SR (Serbian)
		return {aiming='Нишанење', blocked='Блокирано', disabled='Онемогућено', quickswap='Брза замена', default='Подразумевано', custom='Прилагођено'}
	
	elseif locale=='sv' then -- SV (Swedish)
		return {aiming='Siktar', blocked='Blockerad', disabled='Inaktiverad', quickswap='Snabbbyte', default='Standard', custom='Anpassad'}
	
	elseif locale=='ta' then -- TA (Tamil)
		return {aiming='இமிங்', blocked='தடுக்கப்பட்டது', disabled='முடக்கப்பட்டது', quickswap='விரைவு மாற்றம்', default='இயல்புநிலை', custom='விருப்பம்'}
	
	elseif locale=='th' then -- TH (Thai)
		return {aiming='เล็ง', blocked='บล็อกแล้ว', disabled='ปิดการใช้งาน', quickswap='สลับด่วน', default='ค่าเริ่มต้น', custom='กำหนดเอง'}
	
	elseif locale=='tr' then -- TR (Turkish)
		return {aiming='Nişan alma', blocked='Engellendi', disabled='Devre dışı', quickswap='Hızlı Değişim', default='Varsayılan', custom='Özel'}
	
	elseif locale=='uk' then -- UK (Ukrainian)
		return {aiming='Прицiлювання', blocked='Заблоковано', disabled='Вимкнено', quickswap='Швидка замiна', default='Замовчуванням', custom='Користувацький'}
	
	elseif locale=='ve' then -- VE (Venda)
		return {aiming='U ṱoḓa', blocked='Yo thivhiwa', disabled='Yo thivhelwa', quickswap='U shandula nga u ṱavhanya', default='Zwo dzivhiswaho', custom='Zwo ṱaluswaho'}
	
	elseif locale=='vi' then -- VI (Vietnamese)
		return {aiming='Ngắm', blocked='Bị chặn', disabled='Vô hiệu hóa', quickswap='Đổi nhanh', default='Mặc định', custom='Tùy chỉnh'}
	
	elseif locale=='zh' then -- ZH (Chinese)
		return {aiming='瞄准', blocked='已阻止', disabled='已禁用', quickswap='快速切换', default='默认', custom='自定义'}
	
	elseif locale=='zu' then -- ZU (Zulu)
		return {aiming='Ukuqondisa', blocked='Kuvinjiwe', disabled='Kukhutshaziwe', quickswap='Ukushintsha Okusheshayo', default='Okuzenzakalelayo', custom='Ngokwezifiso'}
	
	else -- DEFAULT (English)
		return {aiming='Aiming', blocked='Blocked', disabled='Disabled', quickswap='Quick Swap', default='Default', custom='Custom'}
	end
end
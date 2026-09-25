-- Keep only items with correct local photos; remove the rest from DB
delete from public.menu_items
where id not in (
  'samosa','veg-momo','chicken-momo','buff-momo','fried-momo',
  'sandwich','chicken-sandwich',
  'dal-bhat','chowmein','chicken-chowmein','fried-rice','veg-fried-rice',
  'thukpa','chicken-thukpa',
  'water','coke','milk-tea','coffee'
);

-- Ensure is_veg flags
update public.menu_items set is_veg = true where id in ('samosa','veg-momo','sandwich','dal-bhat','chowmein','veg-fried-rice','thukpa','water','coke','milk-tea','coffee');
update public.menu_items set is_veg = false where id in ('chicken-momo','buff-momo','fried-momo','chicken-sandwich','chicken-chowmein','fried-rice','chicken-thukpa');

-- Clear bad remote image_url so app uses local assets
update public.menu_items set image_url = null;

notify pgrst, 'reload schema';

select id, name, is_veg from public.menu_items order by category, name;
